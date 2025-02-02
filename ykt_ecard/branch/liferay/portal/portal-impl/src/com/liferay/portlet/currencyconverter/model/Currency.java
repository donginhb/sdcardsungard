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

package com.liferay.portlet.currencyconverter.model;

import java.io.Serializable;

/**
 * <a href="Currency.java.html"><b><i>View Source</i></b></a>
 *
 * @author Brian Wing Shun Chan
 *
 */
public class Currency implements Serializable {

	public static final String DEFAULT_FROM = "USD";

	public static final String DEFAULT_TO = "EUR";

	public Currency(String symbol, double rate) {
		_symbol = symbol;
		_rate = rate;
	}

	public String getSymbol() {
		return _symbol;
	}

	public String getFromSymbol() {
		if ((_symbol != null) && (_symbol.length() == 6)) {
			return _symbol.substring(0, 3);
		}

		return DEFAULT_FROM;
	}

	public String getToSymbol() {
		if ((_symbol != null) && (_symbol.length() == 6)) {
			return _symbol.substring(3, 6);
		}

		return DEFAULT_TO;
	}

	public double getRate() {
		return _rate;
	}

	private String _symbol;
	private double _rate;

}