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

package com.liferay.util.servlet;

import java.util.Collections;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.portlet.PortletRequest;
import javax.portlet.PortletSession;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * <a href="SessionMessages.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class SessionMessages {

	public static final String KEY = SessionMessages.class.getName();

	// Servlet Request

	public static void add(HttpServletRequest req, String key) {
		add(req.getSession(), key);
	}

	public static void add(HttpSession ses, String key) {
		Map messages = _getMessages(ses);

		messages.put(key, key);
	}

	public static void add(HttpServletRequest req, String key, Object value) {
		add(req.getSession(), key, value);
	}

	public static void add(HttpSession ses, String key, Object value) {
		Map messages = _getMessages(ses);

		messages.put(key, value);
	}

	public static void clear(HttpServletRequest req) {
		clear(req.getSession());
	}

	public static void clear(HttpSession ses) {
		Map messages = _getMessages(ses);

		messages.clear();
	}

	public static boolean contains(HttpServletRequest req, String key) {
		return contains(req.getSession(), key);
	}

	public static boolean contains(HttpSession ses, String key) {
		Map messages = _getMessages(ses);

		return messages.containsKey(key);
	}

	public static Object get(HttpServletRequest req, String key) {
		return get(req.getSession(), key);
	}

	public static Object get(HttpSession ses, String key) {
		Map messages = _getMessages(ses);

		return messages.get(key);
	}

	public static boolean isEmpty(HttpServletRequest req) {
		return isEmpty(req.getSession());
	}

	public static boolean isEmpty(HttpSession ses) {
		Map messages = _getMessages(ses);

		return messages.isEmpty();
	}

	public static Iterator iterator(HttpServletRequest req) {
		return iterator(req.getSession());
	}

	public static Iterator iterator(HttpSession ses) {
		Map messages = _getMessages(ses);

		return Collections.unmodifiableSet(messages.keySet()).iterator();
	}

	public static void print(HttpServletRequest req) {
		print(req.getSession());
	}

	public static void print(HttpSession ses) {
		Iterator itr = iterator(ses);

		while (itr.hasNext()) {
			System.out.println(itr.next());
		}
	}

	public static int size(HttpServletRequest req) {
		return size(req.getSession());
	}

	public static int size(HttpSession ses) {
		Map messages = _getMessages(ses);

		return messages.size();
	}

	private static Map _getMessages(HttpSession ses) {
		Map messages = null;

		try {
			messages = (Map)ses.getAttribute(KEY);

			if (messages == null) {
				messages = new LinkedHashMap();

				ses.setAttribute(KEY, messages);
			}
		}
		catch (IllegalStateException ise) {
			messages = new LinkedHashMap();
		}

		return messages;
	}

	// Portlet Request

	public static void add(PortletRequest req, String key) {
		add(req.getPortletSession(), key);
	}

	public static void add(PortletSession ses, String key) {
		Map messages = _getMessages(ses);

		messages.put(key, key);
	}

	public static void add(PortletRequest req, String key, Object value) {
		add(req.getPortletSession(), key, value);
	}

	public static void add(PortletSession ses, String key, Object value) {
		Map messages = _getMessages(ses);

		messages.put(key, value);
	}

	public static void clear(PortletRequest req) {
		clear(req.getPortletSession());
	}

	public static void clear(PortletSession ses) {
		Map messages = _getMessages(ses);

		messages.clear();
	}

	public static boolean contains(PortletRequest req, String key) {
		return contains(req.getPortletSession(), key);
	}

	public static boolean contains(PortletSession ses, String key) {
		Map messages = _getMessages(ses);

		return messages.containsKey(key);
	}

	public static Object get(PortletRequest req, String key) {
		return get(req.getPortletSession(), key);
	}

	public static Object get(PortletSession ses, String key) {
		Map messages = _getMessages(ses);

		return messages.get(key);
	}

	public static boolean isEmpty(PortletRequest req) {
		return isEmpty(req.getPortletSession());
	}

	public static boolean isEmpty(PortletSession ses) {
		Map messages = _getMessages(ses);

		return messages.isEmpty();
	}

	public static Iterator iterator(PortletRequest req) {
		return iterator(req.getPortletSession());
	}

	public static Iterator iterator(PortletSession ses) {
		Map messages = _getMessages(ses);

		return Collections.unmodifiableSet(messages.keySet()).iterator();
	}

	public static void print(PortletRequest req) {
		print(req.getPortletSession());
	}

	public static void print(PortletSession ses) {
		Iterator itr = iterator(ses);

		while (itr.hasNext()) {
			System.out.println(itr.next());
		}
	}

	public static int size(PortletRequest req) {
		return size(req.getPortletSession());
	}

	public static int size(PortletSession ses) {
		Map messages = _getMessages(ses);

		return messages.size();
	}

	private static Map _getMessages(PortletSession ses) {
		Map messages = null;

		try {
			messages = (Map)ses.getAttribute(KEY);

			if (messages == null) {
				messages = new LinkedHashMap();

				ses.setAttribute(KEY, messages);
			}
		}
		catch (IllegalStateException ise) {
			messages = new LinkedHashMap();
		}

		return messages;
	}

}