package com.sungard.print;

import com.sungard.common.Configuration;
import junit.framework.TestCase;

/**
 * Created by IntelliJ IDEA.
 * User: Youyiming
 * Date: 2011-7-2
 * Time: 21:57:58
 */
public class PrinterTest extends TestCase {
    @Override
    protected void setUp() throws Exception {
        super.setUp();
        Configuration.load();
    }

    @Override
    protected void tearDown() throws Exception {
        super.tearDown();
    }

    public void testPrint() {
        Printer printer = new Printer();
        AbstractDocument document = new PosDocument();
        String content = "火车票收款单<br>学号：20101132<br>姓名：张三<br>班级：计算机01<br>火车票：12.7元<br>汽车票:3元<br>证件费:7元<br>其它一:4元<br>其它二:0元<br>费用合计:26.7元<br>扣款员:游毅明<br>日期:2011-06-16 14:05";
        document.addPage(content);
        printer.setDocument(document);
//        printer.print();
    }
}
