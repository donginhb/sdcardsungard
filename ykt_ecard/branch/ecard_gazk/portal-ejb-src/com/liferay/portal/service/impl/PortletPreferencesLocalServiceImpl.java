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

package com.liferay.portal.service.impl;

import com.liferay.portal.NoSuchPortletPreferencesException;
import com.liferay.portal.PortalException;
import com.liferay.portal.SystemException;
import com.liferay.portal.model.Layout;
import com.liferay.portal.model.Portlet;
import com.liferay.portal.model.PortletPreferences;
import com.liferay.portal.service.persistence.LayoutPK;
import com.liferay.portal.service.persistence.PortletPreferencesPK;
import com.liferay.portal.service.persistence.PortletPreferencesUtil;
import com.liferay.portal.service.spring.PortletPreferencesLocalService;
import com.liferay.portal.service.spring.PortletServiceUtil;
import com.liferay.portlet.PortletPreferencesImpl;
import com.liferay.portlet.PortletPreferencesSerializer;

import java.util.Map;

/**
 * <a href="PortletPreferencesLocalServiceImpl.java.html"><b><i>View Source</i>
 * </b></a>
 *
 * @author  Brian Wing Shun Chan
 * @version $Revision: 1.3 $
 *
 */
public class PortletPreferencesLocalServiceImpl
	implements PortletPreferencesLocalService {

	public void deleteAllByLayout(LayoutPK pk) throws SystemException {
		if (Layout.isGroup(pk.layoutId)) {
			PortletPreferencesUtil.removeByLayoutId(pk.layoutId);

			PortletPreferencesLocalUtil.clearPreferencesPool();
		}
		else {
			PortletPreferencesUtil.removeByL_U(pk.layoutId, pk.userId);

			PortletPreferencesLocalUtil.clearPreferencesPool(pk.userId);
		}
	}

	public void deleteAllByUser(String userId) throws SystemException {
		PortletPreferencesUtil.removeByUserId(userId);

		PortletPreferencesLocalUtil.clearPreferencesPool(userId);
	}

	public javax.portlet.PortletPreferences getDefaultPreferences(
			String companyId, String portletId)
		throws PortalException, SystemException {

		Portlet portlet = PortletServiceUtil.getPortletById(
			companyId, portletId);

		return PortletPreferencesSerializer.fromDefaultXML(
			portlet.getDefaultPreferences());
	}

	public PortletPreferences getPortletPreferences(PortletPreferencesPK pk)
		throws PortalException, SystemException {

		return PortletPreferencesUtil.findByPrimaryKey(pk);
	}

	public javax.portlet.PortletPreferences getPreferences(
			String companyId, PortletPreferencesPK pk)
		throws PortalException, SystemException {

		Map prefsPool = PortletPreferencesLocalUtil.getPreferencesPool(
			pk.userId);

		PortletPreferencesImpl prefs =
			(PortletPreferencesImpl)prefsPool.get(pk);

		if (prefs == null) {
			PortletPreferences portletPreferences = null;

			Portlet portlet = PortletServiceUtil.getPortletById(
				companyId, pk.portletId);

			try {
				portletPreferences =
					PortletPreferencesUtil.findByPrimaryKey(pk);
			}
			catch (NoSuchPortletPreferencesException nsppe) {
				portletPreferences = PortletPreferencesUtil.create(pk);

				portletPreferences.setPreferences(
					portlet.getDefaultPreferences());

				PortletPreferencesUtil.update(portletPreferences);
			}

			prefs = PortletPreferencesSerializer.fromXML(
				companyId, pk, portletPreferences.getPreferences());

			prefsPool.put(pk, prefs);
		}

		return (PortletPreferencesImpl)prefs.clone();
	}

	public PortletPreferences updatePreferences(
			PortletPreferencesPK pk, PortletPreferencesImpl prefs)
		throws PortalException, SystemException {

		PortletPreferences portletPrefences =
			PortletPreferencesUtil.findByPrimaryKey(pk);

		String xml = PortletPreferencesSerializer.toXML(prefs);

		portletPrefences.setPreferences(xml);

		PortletPreferencesUtil.update(portletPrefences);

		PortletPreferencesLocalUtil.clearPreferencesPool(pk.userId);

		return portletPrefences;
	}

}