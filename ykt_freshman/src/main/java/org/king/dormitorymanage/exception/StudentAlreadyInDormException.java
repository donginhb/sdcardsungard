/**
 * Copyright (C), 2000-2005, Kingstar Co., Ltd. 
 * File name: DormitoryNotEnoughException.java
 * Description: TODO
 * Modify History����Change Log��:  
 * �������ͣ��������޸ĵȣ�   ��������       ������             �������ݼ���
 * ����  				 2006-5-22     ������             
 * <p>
 *
 * @author      ������
 * @version     1.0
 * @since       1.0
 */
package org.king.dormitorymanage.exception;

import org.king.framework.exception.BaseException;

public class StudentAlreadyInDormException extends BaseException {


	public StudentAlreadyInDormException() {
		super();
	}

	public StudentAlreadyInDormException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public StudentAlreadyInDormException(String arg0) {
		super(arg0);
	}

	public StudentAlreadyInDormException(Throwable arg0) {
		super(arg0);
	}
	
	

}