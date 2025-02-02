#ifndef  __T_device_H_
#define  __T_device_H_
typedef struct 
{
		int	device_id;
		char	device_name[150+1];
		char	dev999_id[8+1];
		char	devphy999_id[8+1];
		int	dev999_no;
		char	devtype[4+1];
		char	devversion[8+1];
		char	cardstr[2+1];
		char	cardtype[64+1];
		int	portcount;
		int	fdev_id;
		int	portno;
		int	state_id;
		int	joinmode;
		char	comadd[16+1];
		char	port[6+1];
		int	baudrate;
		int	comtype;
		char	bsheetvdate[12+1];
		char	bsheetver[12+1];
		int	lasttraserno;
		char	lasttradate[20+1];
		int	lastshutserno;
		char	lastshutdate[20+1];
		char	syspwd[6+1];
		char	admpwd[6+1];
		int	pwdonoff;
		char	puserno[3+1];
		char	cardset[64+1];
		char	funonoff[2+1];
		int	cardusenum;
		int	maxdeposit;
		int	mindeposit;
		int	ration;
		int	maxtrade;
		char	shuttimes[64+1];
		char	card65pwd[64+1];
		char	authpwd[64+1];
		int	ftflag;
		int	feetype;
		int	phytype;
		int	web_level;
		int	subsystem_id;
		int	area;
		char	init_key[32+1];
		char	manager[20+1];
		char	tel[20+1];
		char	address[150+1];
		char	operate_time[26+1];
		char	comments[150+1];
		int	is_fee_code;
}T_t_pif_device;
int DB_t_pif_device_add(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_read_by_device_id(int v_device_id,T_t_pif_device *pt_pif_device);
int DB_t_pif_device_read_by_devphy999_id(char *v_devphy999_id,T_t_pif_device *pt_pif_device);
int DB_t_pif_device_read_lock_by_cur_and_device_id(int v_device_id,T_t_pif_device *pt_pif_device);
int DB_t_pif_device_update_lock_by_cur(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_free_lock_cur();
int DB_t_pif_device_open_select_by_c1_and_subsystem_id(int v_subsystem_id);
int DB_t_pif_device_fetch_select_by_c1(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_free_lock_c1();
int DB_t_pif_device_open_select_by_c2();
int DB_t_pif_device_fetch_select_by_c2(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_free_lock_c2();
int DB_t_pif_device_open_select_by_c3_and_subsystem_id_and_devtype(int v_subsystem_id,char *v_devtype);
int DB_t_pif_device_fetch_select_by_c3(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_close_select_by_c3();
int DB_t_pif_device_open_select_by_c4_and_devtype(char *v_devtype);
int DB_t_pif_device_fetch_select_by_c4(T_t_pif_device *pt_pif_device);
int DB_t_pif_device_close_select_by_c4();
#endif
