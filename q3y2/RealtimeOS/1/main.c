
#include <linux/init.h>
#include <linux/module.h>


MODULE_DESCRIPTION("Simple Linux driver");
MODULE_LICENSE("GPL");
MODULE_AUTHOR("Apriorit, Inc");


static int simple_driver_init(void)
{
   return 0;
}


static void simple_driver_exit(void)
{
   return;
}


module_init(simple_driver_init);
module_exit(simple_driver_exit);

