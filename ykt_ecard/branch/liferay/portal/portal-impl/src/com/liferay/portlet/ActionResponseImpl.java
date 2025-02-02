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

package com.liferay.portlet;

import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.model.Layout;
import com.liferay.portal.model.Portlet;
import com.liferay.portal.model.User;
import com.liferay.portal.service.PortletLocalServiceUtil;
import com.liferay.portal.util.PortalUtil;
import com.liferay.portal.util.WebKeys;
import com.liferay.util.CollectionFactory;

import java.io.IOException;

import java.lang.reflect.Constructor;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.portlet.ActionResponse;
import javax.portlet.PortletMode;
import javax.portlet.PortletModeException;
import javax.portlet.PortletURL;
import javax.portlet.WindowState;
import javax.portlet.WindowStateException;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <a href="ActionResponseImpl.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class ActionResponseImpl implements ActionResponse {

	public void addProperty(String key, String value) {
	}

	public void setProperty(String key, String value) {
		if (_properties == null) {
			_properties = CollectionFactory.getHashMap();
		}

		_properties.put(key, new String[] {value});
	}

	public PortletURL createActionURL() {
		PortletURL portletURL = createPortletURL(true);

		try {
			portletURL.setWindowState(_req.getWindowState());
		}
		catch (WindowStateException wse) {
		}

		try {
			portletURL.setPortletMode(_req.getPortletMode());
		}
		catch (PortletModeException pme) {
		}

		return portletURL;
	}

	public PortletURL createRenderURL() {
		PortletURL portletURL = createPortletURL(false);

		try {
			portletURL.setWindowState(_req.getWindowState());
		}
		catch (WindowStateException wse) {
		}

		try {
			portletURL.setPortletMode(_req.getPortletMode());
		}
		catch (PortletModeException pme) {
		}

		return portletURL;
	}

	public String getNamespace() {
		return PortalUtil.getPortletNamespace(_portletName);
	}

	public String encodeURL(String path) {
		return path;
	}

	public void setWindowState(WindowState windowState)
		throws WindowStateException {

		if (_redirectLocation != null) {
			throw new IllegalStateException();
		}

		if (!_req.isWindowStateAllowed(windowState)) {
			throw new WindowStateException(windowState.toString(), windowState);
		}

		try {
			_windowState = PortalUtil.updateWindowState(
				_portletName, _user, _layout, windowState,
				_req.getHttpServletRequest());

			_req.setWindowState(_windowState);
		}
		catch (Exception e) {
			throw new WindowStateException(e, windowState);
		}

		_calledSetRenderParameter = true;
	}

	public void setPortletMode(PortletMode portletMode)
		throws PortletModeException {

		if (_redirectLocation != null) {
			throw new IllegalStateException();
		}

		if (!_req.isPortletModeAllowed(portletMode)) {
			throw new PortletModeException(portletMode.toString(), portletMode);
		}

		try {
			_portletMode = PortalUtil.updatePortletMode(
				_portletName, _user, _layout, portletMode,
				_req.getHttpServletRequest());

			_req.setPortletMode(_portletMode);
		}
		catch (Exception e) {
			throw new PortletModeException(e, portletMode);
		}

		_calledSetRenderParameter = true;
	}

	public Map getRenderParameters() {
		return _params;
	}

	public void setRenderParameter(String name, String value) {
		if (_redirectLocation != null) {
			throw new IllegalStateException();
		}

		if ((name == null) || (value == null)) {
			throw new IllegalArgumentException();
		}

		setRenderParameter(name, new String[] {value});
	}

	public void setRenderParameter(String name, String[] values) {
		if (_redirectLocation != null) {
			throw new IllegalStateException();
		}

		if ((name == null) || (values == null)) {
			throw new IllegalArgumentException();
		}

		for (int i = 0; i < values.length; i++) {
			if (values[i] == null) {
				throw new IllegalArgumentException();
			}
		}

		_params.put(
			PortalUtil.getPortletNamespace(_portletName) + name,
			values);

		_calledSetRenderParameter = true;
	}

	public void setRenderParameters(Map params) {
		if (_redirectLocation != null) {
			throw new IllegalStateException();
		}

		if (params == null) {
			throw new IllegalArgumentException();
		}
		else {
			Map newParams = new LinkedHashMap();

			Iterator itr = params.entrySet().iterator();

			while (itr.hasNext()) {
				Map.Entry entry = (Map.Entry)itr.next();

				Object key = entry.getKey();
				Object value = entry.getValue();

				if (key == null) {
					throw new IllegalArgumentException();
				}
				else if (value == null) {
					throw new IllegalArgumentException();
				}

				if (value instanceof String[]) {
					newParams.put(
						PortalUtil.getPortletNamespace(_portletName) + key,
						value);
				}
				else {
					throw new IllegalArgumentException();
				}
			}

			_params = newParams;
		}

		_calledSetRenderParameter = true;
	}

	public String getRedirectLocation() {
		return _redirectLocation;
	}

	public void sendRedirect(String location) throws IOException {
		if ((location == null) ||
			(!location.startsWith("/") && (location.indexOf("://") == -1))) {

			throw new IllegalArgumentException(
				location + " is not a valid redirect");
		}

		if (_calledSetRenderParameter) {
			throw new IllegalStateException(
				"Set render parameter has already been called");
		}

		_redirectLocation = location;
	}

	public HttpServletResponse getHttpServletResponse() {
		return _res;
	}

	protected PortletURL createPortletURL(boolean action) {

		// Wrap portlet URL with a custom wrapper if and only if a custom
		// wrapper for the portlet has been defined

		Portlet portlet = getPortlet();

		String portletURLClass = portlet.getPortletURLClass();

		if (Validator.isNotNull(portletURLClass)) {
			try {
				Class portletURLClassObj = Class.forName(portletURLClass);

				Constructor constructor = portletURLClassObj.getConstructor(
					new Class[] {
						com.liferay.portlet.ActionResponseImpl.class,
						boolean.class
					});

				return (PortletURL)constructor.newInstance(
					new Object[] {this, Boolean.valueOf(action)});
			}
			catch (Exception e) {
				_log.error(e);
			}
		}

		return new PortletURLImpl(
			_req, _portletName, _layout.getPlid(), action);
	}

	protected Layout getLayout() {
		return _layout;
	}

	protected long getPlid() {
		return _plid;
	}

	protected void setPlid(long plid) {
		_plid = plid;

		if (_plid <= 0) {
			Layout layout = (Layout)_req.getAttribute(WebKeys.LAYOUT);

			if (layout != null) {
				_plid = layout.getPlid();
			}
		}
	}

	protected Map getParameterMap() {
		return _params;
	}

	protected PortletMode getPortletMode() {
		return _portletMode;
	}

	protected String getPortletName() {
		return _portletName;
	}

	public Portlet getPortlet() {
		if (_portlet == null) {
			try {
				_portlet = PortletLocalServiceUtil.getPortletById(
					_companyId, _portletName);
			}
			catch (Exception e) {
				_log.error(e);
			}
		}

		return _portlet;
	}

	protected ActionResponseImpl() {
		if (_log.isDebugEnabled()) {
			_log.debug("Creating new instance " + hashCode());
		}
	}

	protected void init(
			ActionRequestImpl req, HttpServletResponse res, String portletName,
			User user, Layout layout, WindowState windowState,
			PortletMode portletMode)
		throws PortletModeException, WindowStateException {

		_req = req;
		_res = res;
		_portletName = portletName;
		_companyId = layout.getCompanyId();
		_user = user;
		_layout = layout;
		setPlid(layout.getPlid());
		setWindowState(windowState);
		setPortletMode(portletMode);
		_params = new LinkedHashMap();
		_calledSetRenderParameter = false;
	}

	protected void recycle() {
		if (_log.isDebugEnabled()) {
			_log.debug("Recycling instance " + hashCode());
		}

		_req = null;
		_res = null;
		_portletName = null;
		_companyId = 0;
		_user = null;
		_layout = null;
		_plid = 0;
		_windowState = null;
		_portletMode = null;
		_params = new LinkedHashMap();
		_redirectLocation = null;
		_calledSetRenderParameter = false;
	}

	protected ActionRequestImpl getReq() {
		return _req;
	}

	protected User getUser() {
		return _user;
	}

	protected Map getProperties() {
		return _properties;
	}

	protected WindowState getWindowState() {
		return _windowState;
	}

	protected boolean isCalledSetRenderParameter() {
		return _calledSetRenderParameter;
	}

	private static Log _log = LogFactory.getLog(ActionResponseImpl.class);

	private ActionRequestImpl _req;
	private HttpServletResponse _res;
	private String _portletName;
	private Portlet _portlet;
	private long _companyId;
	private User _user;
	private Layout _layout;
	private long _plid;
	private Map _properties;
	private WindowState _windowState;
	private PortletMode _portletMode;
	private Map _params;
	private String _redirectLocation;
	private boolean _calledSetRenderParameter;

}