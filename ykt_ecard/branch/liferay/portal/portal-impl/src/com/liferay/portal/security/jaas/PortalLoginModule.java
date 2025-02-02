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

package com.liferay.portal.security.jaas;

import com.liferay.portal.kernel.util.ServerDetector;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.util.PropsUtil;

import java.util.Map;

import javax.security.auth.Subject;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <a href="PortalLoginModule.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class PortalLoginModule implements LoginModule {

	public PortalLoginModule() {
		String jaasImpl = PropsUtil.get(PropsUtil.PORTAL_JAAS_IMPL);

		if (Validator.isNotNull(jaasImpl)) {
			try {
				_loginModule = (LoginModule)Class.forName(
					jaasImpl).newInstance();
			}
			catch (Exception e) {
				_log.error(e);
			}
		}

		if (_loginModule == null) {

			// Check application servers

			if (ServerDetector.isJBoss()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.jboss.PortalLoginModule();
			}
			else if (ServerDetector.isJOnAS()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.jonas.PortalLoginModule();
			}
			else if (ServerDetector.isResin()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.resin.PortalLoginModule();
			}
			else if (ServerDetector.isWebLogic()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.weblogic.PortalLoginModule();
			}

			// Check servlet containers

			else if (ServerDetector.isJetty()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.jetty.PortalLoginModule();
			}
			else if (ServerDetector.isTomcat()) {
				_loginModule =
					new com.liferay.portal.security.jaas.ext.tomcat.PortalLoginModule();
			}
		}

		if (_log.isDebugEnabled()) {
			_log.debug(_loginModule.getClass().getName());
		}
	}

	public boolean abort() throws LoginException {
		return _loginModule.abort();
	}

	public boolean commit() throws LoginException {
		return _loginModule.commit();
	}

	public void initialize(
		Subject subject, CallbackHandler callbackHandler, Map sharedState,
		Map options) {

		_loginModule.initialize(subject, callbackHandler, sharedState, options);
	}

	public boolean login() throws LoginException {
		return _loginModule.login();
	}

	public boolean logout() throws LoginException {
		return _loginModule.logout();
	}

 	private static Log _log = LogFactory.getLog(PortalLoginModule.class);

	private LoginModule _loginModule;

}