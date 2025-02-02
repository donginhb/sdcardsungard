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

package com.liferay.portal.kernel.portlet;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;

import java.util.Locale;

import javax.portlet.PortletURL;
import javax.portlet.RenderResponse;

/**
 * <a href="RenderResponseWrapper.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class RenderResponseWrapper
	extends PortletResponseWrapper implements RenderResponse {

	public RenderResponseWrapper(RenderResponse res) {
		super(res);

		_res = res;
	}

	public String getContentType() {
		return _res.getContentType();
	}

	public PortletURL createRenderURL() {
		return _res.createRenderURL();
	}

	public PortletURL createActionURL() {
		return _res.createActionURL();
	}

	public String getNamespace() {
		return _res.getNamespace();
	}

	public void setTitle(String title) {
		_res.setTitle(title);
	}

	public void setContentType(String type) {
		_res.setContentType(type);
	}

	public String getCharacterEncoding() {
		return _res.getCharacterEncoding();
	}

	public PrintWriter getWriter() throws IOException {
		return _res.getWriter();
	}

	public Locale getLocale() {
		return _res.getLocale();
	}

	public void setBufferSize(int size) {
		_res.setBufferSize(size);
	}

	public int getBufferSize() {
		return _res.getBufferSize();
	}

	public void flushBuffer() throws IOException {
		_res.flushBuffer();
	}

	public void resetBuffer() {
		_res.resetBuffer();
	}

	public boolean isCommitted() {
		return _res.isCommitted();
	}

	public void reset() {
		_res.reset();
	}

	public OutputStream getPortletOutputStream() throws IOException {
		return _res.getPortletOutputStream();
	}

	private RenderResponse _res;

}