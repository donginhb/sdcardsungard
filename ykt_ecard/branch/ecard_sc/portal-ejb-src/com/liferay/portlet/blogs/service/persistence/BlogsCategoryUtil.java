/**
 * Copyright (c) 2000-2005 Liferay, LLC. All rights reserved.
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

package com.liferay.portlet.blogs.service.persistence;

import com.liferay.portal.model.ModelListener;
import com.liferay.portal.util.PropsUtil;

import com.liferay.util.GetterUtil;
import com.liferay.util.InstancePool;
import com.liferay.util.Validator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <a href="BlogsCategoryUtil.java.html"><b><i>View Source</i></b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.183 $
 *
 */
public class BlogsCategoryUtil {
	public static String PERSISTENCE = GetterUtil.get(PropsUtil.get(
				"value.object.persistence.com.liferay.portlet.blogs.model.BlogsCategory"),
			"com.liferay.portlet.blogs.service.persistence.BlogsCategoryPersistence");
	public static String LISTENER = GetterUtil.getString(PropsUtil.get(
				"value.object.listener.com.liferay.portlet.blogs.model.BlogsCategory"));

	public static com.liferay.portlet.blogs.model.BlogsCategory create(
		java.lang.String categoryId) {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.create(categoryId);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory remove(
		java.lang.String categoryId)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);
		ModelListener listener = null;

		if (Validator.isNotNull(LISTENER)) {
			try {
				listener = (ModelListener)Class.forName(LISTENER).newInstance();
			}
			catch (Exception e) {
				_log.error(e.getMessage());
			}
		}

		if (listener != null) {
			listener.onBeforeRemove(findByPrimaryKey(categoryId));
		}

		com.liferay.portlet.blogs.model.BlogsCategory blogsCategory = persistence.remove(categoryId);

		if (listener != null) {
			listener.onAfterRemove(blogsCategory);
		}

		return blogsCategory;
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory update(
		com.liferay.portlet.blogs.model.BlogsCategory blogsCategory)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);
		ModelListener listener = null;

		if (Validator.isNotNull(LISTENER)) {
			try {
				listener = (ModelListener)Class.forName(LISTENER).newInstance();
			}
			catch (Exception e) {
				_log.error(e.getMessage());
			}
		}

		boolean isNew = blogsCategory.isNew();

		if (listener != null) {
			if (isNew) {
				listener.onBeforeCreate(blogsCategory);
			}
			else {
				listener.onBeforeUpdate(blogsCategory);
			}
		}

		blogsCategory = persistence.update(blogsCategory);

		if (listener != null) {
			if (isNew) {
				listener.onAfterCreate(blogsCategory);
			}
			else {
				listener.onAfterUpdate(blogsCategory);
			}
		}

		return blogsCategory;
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory findByPrimaryKey(
		java.lang.String categoryId)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByPrimaryKey(categoryId);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId,
		int begin, int end) throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId, begin, end);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId,
		int begin, int end, com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId, begin, end, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory findByCompanyId_First(
		java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_First(companyId, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory findByCompanyId_Last(
		java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_Last(companyId, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory[] findByCompanyId_PrevAndNext(
		java.lang.String categoryId, java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_PrevAndNext(categoryId, companyId,
			obc);
	}

	public static java.util.List findByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId);
	}

	public static java.util.List findByUserId(java.lang.String userId,
		int begin, int end) throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId, begin, end);
	}

	public static java.util.List findByUserId(java.lang.String userId,
		int begin, int end, com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId, begin, end, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory findByUserId_First(
		java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_First(userId, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory findByUserId_Last(
		java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_Last(userId, obc);
	}

	public static com.liferay.portlet.blogs.model.BlogsCategory[] findByUserId_PrevAndNext(
		java.lang.String categoryId, java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.blogs.NoSuchCategoryException, 
			com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_PrevAndNext(categoryId, userId, obc);
	}

	public static java.util.List findAll()
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.findAll();
	}

	public static void removeByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);
		persistence.removeByCompanyId(companyId);
	}

	public static void removeByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);
		persistence.removeByUserId(userId);
	}

	public static int countByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.countByCompanyId(companyId);
	}

	public static int countByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		BlogsCategoryPersistence persistence = (BlogsCategoryPersistence)InstancePool.get(PERSISTENCE);

		return persistence.countByUserId(userId);
	}

	private static final Log _log = LogFactory.getLog(BlogsCategoryUtil.class);
}