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

package com.liferay.portlet.documentlibrary.service.persistence;

import com.liferay.portal.model.ModelListener;
import com.liferay.portal.util.PropsUtil;

import com.liferay.util.GetterUtil;
import com.liferay.util.InstancePool;
import com.liferay.util.Validator;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <a href="DLFileProfileUtil.java.html"><b><i>View Source</i></b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.183 $
 *
 */
public class DLFileProfileUtil {
	public static String PERSISTENCE = GetterUtil.get(PropsUtil.get(
				"value.object.persistence.com.liferay.portlet.documentlibrary.model.DLFileProfile"),
			"com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePersistence");
	public static String LISTENER = GetterUtil.getString(PropsUtil.get(
				"value.object.listener.com.liferay.portlet.documentlibrary.model.DLFileProfile"));

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile create(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK) {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.create(dlFileProfilePK);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile remove(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);
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
			listener.onBeforeRemove(findByPrimaryKey(dlFileProfilePK));
		}

		com.liferay.portlet.documentlibrary.model.DLFileProfile dlFileProfile = persistence.remove(dlFileProfilePK);

		if (listener != null) {
			listener.onAfterRemove(dlFileProfile);
		}

		return dlFileProfile;
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile update(
		com.liferay.portlet.documentlibrary.model.DLFileProfile dlFileProfile)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);
		ModelListener listener = null;

		if (Validator.isNotNull(LISTENER)) {
			try {
				listener = (ModelListener)Class.forName(LISTENER).newInstance();
			}
			catch (Exception e) {
				_log.error(e.getMessage());
			}
		}

		boolean isNew = dlFileProfile.isNew();

		if (listener != null) {
			if (isNew) {
				listener.onBeforeCreate(dlFileProfile);
			}
			else {
				listener.onBeforeUpdate(dlFileProfile);
			}
		}

		dlFileProfile = persistence.update(dlFileProfile);

		if (listener != null) {
			if (isNew) {
				listener.onAfterCreate(dlFileProfile);
			}
			else {
				listener.onAfterUpdate(dlFileProfile);
			}
		}

		return dlFileProfile;
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByPrimaryKey(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByPrimaryKey(dlFileProfilePK);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId,
		int begin, int end) throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId, begin, end);
	}

	public static java.util.List findByCompanyId(java.lang.String companyId,
		int begin, int end, com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId(companyId, begin, end, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByCompanyId_First(
		java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_First(companyId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByCompanyId_Last(
		java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_Last(companyId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile[] findByCompanyId_PrevAndNext(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK,
		java.lang.String companyId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByCompanyId_PrevAndNext(dlFileProfilePK,
			companyId, obc);
	}

	public static java.util.List findByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId);
	}

	public static java.util.List findByUserId(java.lang.String userId,
		int begin, int end) throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId, begin, end);
	}

	public static java.util.List findByUserId(java.lang.String userId,
		int begin, int end, com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId(userId, begin, end, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByUserId_First(
		java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_First(userId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByUserId_Last(
		java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_Last(userId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile[] findByUserId_PrevAndNext(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK,
		java.lang.String userId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByUserId_PrevAndNext(dlFileProfilePK, userId, obc);
	}

	public static java.util.List findByC_R(java.lang.String companyId,
		java.lang.String repositoryId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R(companyId, repositoryId);
	}

	public static java.util.List findByC_R(java.lang.String companyId,
		java.lang.String repositoryId, int begin, int end)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R(companyId, repositoryId, begin, end);
	}

	public static java.util.List findByC_R(java.lang.String companyId,
		java.lang.String repositoryId, int begin, int end,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R(companyId, repositoryId, begin, end, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByC_R_First(
		java.lang.String companyId, java.lang.String repositoryId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R_First(companyId, repositoryId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile findByC_R_Last(
		java.lang.String companyId, java.lang.String repositoryId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R_Last(companyId, repositoryId, obc);
	}

	public static com.liferay.portlet.documentlibrary.model.DLFileProfile[] findByC_R_PrevAndNext(
		com.liferay.portlet.documentlibrary.service.persistence.DLFileProfilePK dlFileProfilePK,
		java.lang.String companyId, java.lang.String repositoryId,
		com.liferay.util.dao.hibernate.OrderByComparator obc)
		throws com.liferay.portlet.documentlibrary.NoSuchFileProfileException, 
			com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findByC_R_PrevAndNext(dlFileProfilePK, companyId,
			repositoryId, obc);
	}

	public static java.util.List findAll()
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.findAll();
	}

	public static void removeByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);
		persistence.removeByCompanyId(companyId);
	}

	public static void removeByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);
		persistence.removeByUserId(userId);
	}

	public static void removeByC_R(java.lang.String companyId,
		java.lang.String repositoryId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);
		persistence.removeByC_R(companyId, repositoryId);
	}

	public static int countByCompanyId(java.lang.String companyId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.countByCompanyId(companyId);
	}

	public static int countByUserId(java.lang.String userId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.countByUserId(userId);
	}

	public static int countByC_R(java.lang.String companyId,
		java.lang.String repositoryId)
		throws com.liferay.portal.SystemException {
		DLFileProfilePersistence persistence = (DLFileProfilePersistence)InstancePool.get(PERSISTENCE);

		return persistence.countByC_R(companyId, repositoryId);
	}

	private static final Log _log = LogFactory.getLog(DLFileProfileUtil.class);
}