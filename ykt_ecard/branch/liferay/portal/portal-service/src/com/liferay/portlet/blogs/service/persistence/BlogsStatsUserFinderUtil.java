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

package com.liferay.portlet.blogs.service.persistence;

/**
 * <a href="BlogsStatsUserFinderUtil.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class BlogsStatsUserFinderUtil {
	public static int countByOrganizationId(long organizationId)
		throws com.liferay.portal.SystemException {
		return getFinder().countByOrganizationId(organizationId);
	}

	public static int countByOrganizationIds(java.util.List organizationIds)
		throws com.liferay.portal.SystemException {
		return getFinder().countByOrganizationIds(organizationIds);
	}

	public static java.util.List findByOrganizationId(long organizationId,
		int begin, int end, com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		return getFinder().findByOrganizationId(organizationId, begin, end, obc);
	}

	public static java.util.List findByOrganizationIds(
		java.util.List organizationIds, int begin, int end,
		com.liferay.portal.kernel.util.OrderByComparator obc)
		throws com.liferay.portal.SystemException {
		return getFinder().findByOrganizationIds(organizationIds, begin, end,
			obc);
	}

	public static BlogsStatsUserFinder getFinder() {
		return _getUtil()._finder;
	}

	public void setFinder(BlogsStatsUserFinder finder) {
		_finder = finder;
	}

	private static BlogsStatsUserFinderUtil _getUtil() {
		if (_util == null) {
			_util = (BlogsStatsUserFinderUtil)com.liferay.portal.kernel.bean.BeanLocatorUtil.locate(_UTIL);
		}

		return _util;
	}

	private static final String _UTIL = BlogsStatsUserFinderUtil.class.getName();
	private static BlogsStatsUserFinderUtil _util;
	private BlogsStatsUserFinder _finder;
}