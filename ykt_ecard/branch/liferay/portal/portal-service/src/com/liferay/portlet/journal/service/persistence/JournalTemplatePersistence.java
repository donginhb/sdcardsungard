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

package com.liferay.portlet.journal.service.persistence;

/**
 * <a href="JournalTemplatePersistence.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public interface JournalTemplatePersistence {
	public com.liferay.portlet.journal.model.JournalTemplate create(long id);

	public com.liferay.portlet.journal.model.JournalTemplate remove(long id)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate remove(
		com.liferay.portlet.journal.model.JournalTemplate journalTemplate)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate update(
		com.liferay.portlet.journal.model.JournalTemplate journalTemplate)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate update(
		com.liferay.portlet.journal.model.JournalTemplate journalTemplate,
		boolean merge) throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate updateImpl(
		com.liferay.portlet.journal.model.JournalTemplate journalTemplate,
		boolean merge) throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByPrimaryKey(
		long id)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate fetchByPrimaryKey(
		long id) throws com.liferay.portal.SystemException;

	public java.util.List findByUuid(java.lang.String uuid)
		throws com.liferay.portal.SystemException;

	public java.util.List findByUuid(java.lang.String uuid, int begin, int end)
		throws com.liferay.portal.SystemException;

	public java.util.List findByUuid(java.lang.String uuid, int begin, int end,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByUuid_First(
		java.lang.String uuid,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findByUuid_Last(
		java.lang.String uuid,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate[] findByUuid_PrevAndNext(
		long id, java.lang.String uuid,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findByUUID_G(
		java.lang.String uuid, long groupId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate fetchByUUID_G(
		java.lang.String uuid, long groupId)
		throws com.liferay.portal.SystemException;

	public java.util.List findByGroupId(long groupId)
		throws com.liferay.portal.SystemException;

	public java.util.List findByGroupId(long groupId, int begin, int end)
		throws com.liferay.portal.SystemException;

	public java.util.List findByGroupId(long groupId, int begin, int end,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByGroupId_First(
		long groupId, com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findByGroupId_Last(
		long groupId, com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate[] findByGroupId_PrevAndNext(
		long id, long groupId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public java.util.List findByTemplateId(java.lang.String templateId)
		throws com.liferay.portal.SystemException;

	public java.util.List findByTemplateId(java.lang.String templateId,
		int begin, int end) throws com.liferay.portal.SystemException;

	public java.util.List findByTemplateId(java.lang.String templateId,
		int begin, int end, com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByTemplateId_First(
		java.lang.String templateId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findByTemplateId_Last(
		java.lang.String templateId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate[] findByTemplateId_PrevAndNext(
		long id, java.lang.String templateId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findBySmallImageId(
		long smallImageId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate fetchBySmallImageId(
		long smallImageId) throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByG_T(
		long groupId, java.lang.String templateId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate fetchByG_T(
		long groupId, java.lang.String templateId)
		throws com.liferay.portal.SystemException;

	public java.util.List findByG_S(long groupId, java.lang.String structureId)
		throws com.liferay.portal.SystemException;

	public java.util.List findByG_S(long groupId, java.lang.String structureId,
		int begin, int end) throws com.liferay.portal.SystemException;

	public java.util.List findByG_S(long groupId, java.lang.String structureId,
		int begin, int end, com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException;

	public com.liferay.portlet.journal.model.JournalTemplate findByG_S_First(
		long groupId, java.lang.String structureId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate findByG_S_Last(
		long groupId, java.lang.String structureId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public com.liferay.portlet.journal.model.JournalTemplate[] findByG_S_PrevAndNext(
		long id, long groupId, java.lang.String structureId,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public java.util.List findWithDynamicQuery(
		com.liferay.portal.kernel.dao.DynamicQueryInitializer queryInitializer)
		throws com.liferay.portal.SystemException;

	public java.util.List findWithDynamicQuery(
		com.liferay.portal.kernel.dao.DynamicQueryInitializer queryInitializer,
		int begin, int end) throws com.liferay.portal.SystemException;

	public java.util.List findAll() throws com.liferay.portal.SystemException;

	public java.util.List findAll(int begin, int end)
		throws com.liferay.portal.SystemException;

	public java.util.List findAll(int begin, int end,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException;

	public void removeByUuid(java.lang.String uuid)
		throws com.liferay.portal.SystemException;

	public void removeByUUID_G(java.lang.String uuid, long groupId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public void removeByGroupId(long groupId)
		throws com.liferay.portal.SystemException;

	public void removeByTemplateId(java.lang.String templateId)
		throws com.liferay.portal.SystemException;

	public void removeBySmallImageId(long smallImageId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public void removeByG_T(long groupId, java.lang.String templateId)
		throws com.liferay.portal.SystemException, 
			com.liferay.portlet.journal.NoSuchTemplateException;

	public void removeByG_S(long groupId, java.lang.String structureId)
		throws com.liferay.portal.SystemException;

	public void removeAll() throws com.liferay.portal.SystemException;

	public int countByUuid(java.lang.String uuid)
		throws com.liferay.portal.SystemException;

	public int countByUUID_G(java.lang.String uuid, long groupId)
		throws com.liferay.portal.SystemException;

	public int countByGroupId(long groupId)
		throws com.liferay.portal.SystemException;

	public int countByTemplateId(java.lang.String templateId)
		throws com.liferay.portal.SystemException;

	public int countBySmallImageId(long smallImageId)
		throws com.liferay.portal.SystemException;

	public int countByG_T(long groupId, java.lang.String templateId)
		throws com.liferay.portal.SystemException;

	public int countByG_S(long groupId, java.lang.String structureId)
		throws com.liferay.portal.SystemException;

	public int countAll() throws com.liferay.portal.SystemException;
}