#ifndef  __T_feetype_H_
#define  __T_feetype_H_
typedef struct 
{
		int	fee_type;
		char	fee_name[120+1];
		char	coments[150+1];
		int	is_outfee;
}T_t_pif_feetype;
int DB_t_pif_feetype_open_select_by_cur1();
int DB_t_pif_feetype_fetch_select_by_cur1(T_t_pif_feetype *pt_pif_feetype);
int DB_t_pif_feetype_close_select_by_cur1();
#endif
endif
