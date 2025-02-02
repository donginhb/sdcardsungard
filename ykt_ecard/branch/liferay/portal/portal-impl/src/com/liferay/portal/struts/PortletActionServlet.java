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

package com.liferay.portal.struts;

import com.liferay.portal.util.WebKeys;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;

import org.apache.struts.Globals;
import org.apache.struts.action.ActionServlet;
import org.apache.struts.config.ModuleConfig;

/**
 * <a href="PortletActionServlet.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class PortletActionServlet extends ActionServlet {

	public void init(ServletConfig config) throws ServletException {
		super.init(config);

		ServletContext ctx = getServletContext();

		ModuleConfig moduleConfig =
			(ModuleConfig)ctx.getAttribute(Globals.MODULE_KEY);

		PortletRequestProcessor portletReqProcessor =
			PortletRequestProcessor.getInstance(this, moduleConfig);

		ctx.setAttribute(WebKeys.PORTLET_STRUTS_PROCESSOR, portletReqProcessor);
	}

}