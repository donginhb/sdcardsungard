/*
 * Copyright 2000-2001,2004 The Apache Software Foundation.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *      http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/* 

 */

package org.apache.wsrp4j.producer.provider;

/**
 * Provides an interface to a class encapsulating Portlet-objects.
 * 
 * @author <a href="mailto:stefan.behl@de.ibm.com">Stefan Behl</a>
 */
public interface Portlet extends Cloneable {

	/**
	 * Returns the portletHandle.
	 *
	 * @return    A String representing the portletHandle.
	 */
	public String getPortletHandle();

	/**
	 * Sets the portletHandle to enable identification of the portlet.
	 *
	 * @param     portletHandle  String to be assigned to handle.
	 */
	public void setPortletHandle(String portletHandle);

}