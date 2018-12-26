#include <linux/miscdevice.h>
#include <linux/fs.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/sched.h>
#include <linux/string.h>
#include <asm/uaccess.h>

static struct file* filp = NULL;

/* Abre disposositivo ou arquivo e retorna o ponteiro. */
struct file* file_open(const char* path, int flags, int rights)
{
    int err = 0;
    struct file* filp = NULL;


/* Para acessar uma região de memória que está além do limite de Endereço Virtual do Espaço do Usuário 
(ou seja, caindo na região de Endereço Virtual do Espaço do Kernel), você primeiro armazena o limite atual. */
    mm_segment_t oldfs;
    oldfs = get_fs();

/* Define o limite como o do Kernel - 4 GB/*/
    set_fs(get_ds());


/* O get_fs() irá recuperar este limite e o set_fs() irá defini-lo com um valor */
/* Operações em memória (Ex: - Ler de um buffer que está no espaço do kernel de um contexto de usuário através de uma system call)*/
    filp = filp_open(path, flags, rights);

/* Define o limite de endereço de retorno para o limite original que foi armazenado na variável old_fs */
    set_fs(oldfs);

    if(IS_ERR(filp)) {
        err = PTR_ERR(filp);
        return NULL;
    }

    return filp;
}

/*Fecha*/
void file_close(struct file* file)
{
    filp_close(file, NULL);
}

/*Para passar o limite de memoria dos regsitradores de segmento usa-se get_fs, get_ds e set_fs, 
para fazer manipulação do espaço de kernel e de usuário, para um ter acesso ao espaço do outro*/
int file_read(struct file* file, unsigned long long offset, unsigned char* data, unsigned int size)
{
    mm_segment_t oldfs;
    int ret;

    oldfs = get_fs();
    set_fs(get_ds());
    ret = vfs_read(file, data, size, &offset);
    set_fs(oldfs);

    return ret;
}

/*Retorna a quantidade de bytes que foram escritos*/
int file_write(struct file* file, unsigned long long offset, unsigned char* data, unsigned int size)
{
    mm_segment_t oldfs;
    int ret;

    oldfs = get_fs();
    set_fs(get_ds());
    ret = vfs_write(file, data, size, &offset);
    set_fs(oldfs);

    return ret;
}



static int sample_open(struct inode *inode, struct file *file)
{
  filp = file_open("/dev/ttyUSB0", O_RDWR, 0666);
    return 0;
}

static int sample_close(struct inode *inodep, struct file *filp)
{
    file_close(filp);
    return 0;
}

/* ssize é um tipo de dados que retorna -1, quando existe erros na função */

static ssize_t sample_write(struct file *file, const char __user *buf,
		       size_t len, loff_t *ppos)
{
    ssize_t recv = file_write(filp,*ppos,buf,len);
    return recv;
}

static const struct file_operations sample_fops = {
/*".owner" este campo informa quem é o proprietário do struct. Isso evita que o módulo seja descarregado quando estiver em operação. Por boas praticas deve-se usar THIS_MODULE.*/
    .owner			= THIS_MODULE,   
    .write			= sample_write,
    .open			= sample_open,
    .release		        = sample_close,
};

struct miscdevice sample_device = {
    .minor = MISC_DYNAMIC_MINOR,
    .name = "morse",
    .fops = &sample_fops,
};

static int __init misc_init(void)
{
    int error;

    error = misc_register(&sample_device);
    if (error) {
        pr_err("Erro em misc_register :(\n");
        return error;
    }

    printk("Driver Registrado :)\n");
    return 0;
}

static void __exit misc_exit(void)
{
    misc_deregister(&sample_device);
    printk("Driver Desregistrado!\n");
}

module_init(misc_init)
module_exit(misc_exit)

MODULE_DESCRIPTION("Morse Driver");
MODULE_AUTHOR("Cairo e Rodrigo");
MODULE_LICENSE("GPL");
