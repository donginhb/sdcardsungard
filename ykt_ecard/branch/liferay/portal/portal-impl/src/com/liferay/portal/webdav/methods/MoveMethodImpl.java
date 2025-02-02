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

package com.liferay.portal.webdav.methods;

import com.liferay.portal.kernel.util.StringMaker;
import com.liferay.portal.webdav.Resource;
import com.liferay.portal.webdav.WebDAVException;
import com.liferay.portal.webdav.WebDAVRequest;
import com.liferay.portal.webdav.WebDAVStorage;
import com.liferay.portal.webdav.WebDAVUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * <a href="MoveMethodImpl.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 * @author Alexander Chow
 *
 */
public class MoveMethodImpl implements Method {

	public int process(WebDAVRequest webDavReq) throws WebDAVException {
		WebDAVStorage storage = webDavReq.getWebDAVStorage();
		HttpServletRequest req = webDavReq.getHttpServletRequest();

		String destination = WebDAVUtil.getDestination(
			req, storage.getRootPath());

		StringMaker sm = new StringMaker();

		if (_log.isInfoEnabled()) {
			sm.append("Destination is " + destination);
		}

		int status = HttpServletResponse.SC_FORBIDDEN;

		if ((!destination.equals(webDavReq.getPath())) &&
			(WebDAVUtil.getGroupId(destination) == webDavReq.getGroupId())) {

			Resource resource = storage.getResource(webDavReq);

			if (resource == null) {
				status = HttpServletResponse.SC_NOT_FOUND;
			}
			else {
				boolean overwrite = WebDAVUtil.isOverwrite(req);

				if (_log.isInfoEnabled()) {
					sm.append(", overwrite is " + overwrite);

					_log.info(sm.toString());
				}

				if (resource.isCollection()) {
					status = storage.moveCollectionResource(
						webDavReq, resource, destination, overwrite);
				}
				else {
					status = storage.moveSimpleResource(
						webDavReq, resource, destination, overwrite);
				}
			}
		}

		return status;
	}

	private static Log _log = LogFactory.getLog(MoveMethodImpl.class);

}