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

package com.liferay.portlet.shopping.model;

import com.liferay.portal.model.BaseModel;

/**
 * <a href="ShoppingItemPriceModel.java.html"><b><i>View Source</i></b></a>
 *
 * <p>
 * ServiceBuilder generated this class. Modifications in this class will be
 * overwritten the next time is generated.
 * </p>
 *
 * <p>
 * This interface is a model that represents the <code>ShoppingItemPrice</code>
 * table in the database.
 * </p>
 *
 * @author Brian Wing Shun Chan
 *
 * @see com.liferay.portlet.shopping.service.model.ShoppingItemPrice
 * @see com.liferay.portlet.shopping.service.model.impl.ShoppingItemPriceImpl
 * @see com.liferay.portlet.shopping.service.model.impl.ShoppingItemPriceModelImpl
 *
 */
public interface ShoppingItemPriceModel extends BaseModel {
	public long getPrimaryKey();

	public void setPrimaryKey(long pk);

	public long getItemPriceId();

	public void setItemPriceId(long itemPriceId);

	public long getItemId();

	public void setItemId(long itemId);

	public int getMinQuantity();

	public void setMinQuantity(int minQuantity);

	public int getMaxQuantity();

	public void setMaxQuantity(int maxQuantity);

	public double getPrice();

	public void setPrice(double price);

	public double getDiscount();

	public void setDiscount(double discount);

	public boolean getTaxable();

	public boolean isTaxable();

	public void setTaxable(boolean taxable);

	public double getShipping();

	public void setShipping(double shipping);

	public boolean getUseShippingFormula();

	public boolean isUseShippingFormula();

	public void setUseShippingFormula(boolean useShippingFormula);

	public int getStatus();

	public void setStatus(int status);

	public ShoppingItemPrice toEscapedModel();
}