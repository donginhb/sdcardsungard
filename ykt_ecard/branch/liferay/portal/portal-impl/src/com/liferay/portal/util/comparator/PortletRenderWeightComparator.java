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

package com.liferay.portal.util.comparator;

import com.liferay.portal.model.Portlet;

import java.io.Serializable;

import java.util.Comparator;

/**
 * <a href="PortletRenderWeightComparator.java.html"><b><i>View Source</i></b>
 * </a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class PortletRenderWeightComparator implements Comparator, Serializable {

	public int compare(Object obj1, Object obj2) {
		Portlet portlet1 = (Portlet)obj1;
		Portlet portlet2 = (Portlet)obj2;

		int renderWeight1 = portlet1.getRenderWeight();
		int renderWeight2 = portlet2.getRenderWeight();

		if (renderWeight1 < renderWeight2) {
			return 1;
		}
		else if (renderWeight1 > renderWeight2) {
			return -1;
		}
		else {
			return portlet1.getPortletId().compareTo(portlet2.getPortletId());
		}
	}

}