/*
 * SNMP Package
 *
 * Copyright (C) 2004, Jonathan Sevy <jsevy@mcs.drexel.edu>
 *
 * This is free software. Redistribution and use in source and binary forms, with
 * or without modification, are permitted provided that the following conditions
 * are met:
 *
 *  1. Redistributions of source code must retain the above copyright notice, this
 *     list of conditions and the following disclaimer.
 *  2. Redistributions in binary form must reproduce the above copyright notice,
 *     this list of conditions and the following disclaimer in the documentation 
 *     and/or other materials provided with the distribution.
 *  3. The name of the author may not be used to endorse or promote products 
 *     derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR IMPLIED 
 * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF 
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO 
 * EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT
 * OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */


package com.kingstargroup.monitorsys.snmp;


/**
*    SNMPv2TrapListener is an interface that must be implemented by any class which wishes to act as 
*    a "listener" for SNMPv2 trap messages sent from remote SNMP entities to an instance of the 
*    SNMPTrapListenerInterface class. The SNMPTrapListenerInterface class listens for trap messages, and 
* 	 passes any it receives on to SNMPv2TrapListener subclasses that have registered with it through its 
*    addv2TrapListener() method.
*/

public interface SNMPv2TrapListener
{
    
    public void processv2Trap(SNMPv2TrapPDU trapPDU);
    
}