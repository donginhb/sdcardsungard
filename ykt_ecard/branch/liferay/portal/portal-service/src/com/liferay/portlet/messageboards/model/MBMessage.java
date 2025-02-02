/**
 * Copyright (c) 2000-2008 Liferay, Inc. All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

package com.liferay.portlet.messageboards.model;


/**
 * <a href="MBMessage.java.html"><b><i>View Source</i></b></a>
 *
 * <p>
 * ServiceBuilder generated this class. Modifications in this class will be
 * overwritten the next time is generated.
 * </p>
 *
 * <p>
 * This interface is a model that represents the <code>MBMessage</code> table
 * in the database.
 * </p>
 *
 * <p>
 * Customize <code>com.liferay.portlet.messageboards.service.model.impl.MBMessageImpl</code>
 * and rerun the ServiceBuilder to generate the new methods.
 * </p>
 *
 * @author Brian Wing Shun Chan
 *
 * @see com.liferay.portlet.messageboards.service.model.MBMessageModel
 * @see com.liferay.portlet.messageboards.service.model.impl.MBMessageImpl
 * @see com.liferay.portlet.messageboards.service.model.impl.MBMessageModelImpl
 *
 */
public interface MBMessage extends MBMessageModel {
	public java.lang.String getUserUuid()
		throws com.liferay.portal.SystemException;

	public void setUserUuid(java.lang.String userUuid);

	public com.liferay.portlet.messageboards.model.MBCategory getCategory();

	public boolean isRoot();

	public boolean isReply();

	public boolean isDiscussion();

	public double getPriority()
		throws com.liferay.portal.SystemException, 
			com.liferay.portal.PortalException;

	public void setPriority(double priority);

	public java.lang.String getThreadAttachmentsDir();

	public java.lang.String getAttachmentsDir();

	public void setAttachmentsDir(java.lang.String attachmentsDir);

	public java.lang.String getBody(boolean translated);

	public java.lang.String[] getTagsEntries()
		throws com.liferay.portal.SystemException, 
			com.liferay.portal.PortalException;
}