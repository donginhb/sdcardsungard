document.write("<DIV id='OutlookLikeBar' style='position:absolute;top:" + OB_Top + ";left:" + OB_Left + ";width:" + OB_Width + ";height:" + OB_Height + ";border:" + OB_BorderWidth + " " + OB_BorderStyle + " " + OB_BorderColor + ";background-color:" + OB_BackgroundColor + ";z-index:0;visibility:hidden;clip:rect(0," + OB_Width + "," + OB_Height + ",0)'>");
document.write("<img onMouseUp='OutlookLikeBar.ArrowSelected(this)' onMouseDown='OutlookLikeBar.ArrowClicked(this)' onMouseOver='OutlookLikeBar.OverArrow(this)' onMouseOut='OutlookLikeBar.OutArrow(this);' id='OB_SlideUp' height='" + OB_ArrowHeight + "' width='" + OB_ArrowWidth + "' src='" + OB_DownArrow + "' style='position:absolute;top:0;left:0;cursor:pointer;visibility:hidden;z-index:650'>");
document.write("<img onMouseUp='OutlookLikeBar.ArrowSelected(this)' onMouseDown='OutlookLikeBar.ArrowClicked(this)' onMouseOver='OutlookLikeBar.OverArrow(this)' onMouseOut='OutlookLikeBar.OutArrow(this);' id='OB_SlideDown' height='" + OB_ArrowHeight + "' width='" + OB_ArrowWidth + "' src='" + OB_UpArrow + "' style='position:absolute;top:0;left:0;cursor:pointer;visibility:hidden;z-index:650'>");
var itemNum = 1;
while (eval("window.OutBarFolder" + itemNum))
{
    itemNum++;
}
itemNum--;
j = 1;
while (eval("window.OutBarFolder" + j))
    j++;
i = j - 1;
while (i > 0)
{
    Folder = eval("OutBarFolder" + i)
    window.status = "Outlook-Like Bar is making folder '" + Folder[0] + "'";
    if (i == 1)
    {
        document.write("<INPUT position='UP' id='OB_Button1' TYPE='button' value='" + Folder[0] + "' class='OB1_Class'  onClick='OutlookLikeBar.FolderClicked(" + i + ");SetBgimage(" + i + ");this.blur();'>");
        MakeItems(Folder, i, OB_ButtonHeight);
    }
    else
    {
        document.write("<INPUT position='DOWN' id='OB_Button" + i + "'  TYPE='button' value='" + Folder[0] + "' style=\"position:absolute;top:" + (OB_Height - (j - i) * OB_ButtonHeight - OB_BorderWidth * 2) + "\" class='OBs_Class'  onClick='OutlookLikeBar.FolderClicked(" + i + ");SetBgimage(" + i + ");this.blur()';>");
        MakeItems(Folder, i, (OB_Height - (j - i) * OB_ButtonHeight - OB_BorderWidth * 2) + OB_ButtonHeight);
    }
    i--;
}
document.write("</DIV>");
document.write("<style>");
document.write(".OB1_Class{position:absolute;top:0;left:0;width:" + OB_Width + ";height:" + OB_ButtonHeight + ";line-height:2;font-size:" + OB_ButtonFontSize + "pt;cursor:pointer;color:" + OB_ButtonFontColor + ";border-width:0;background-color:#2159DA}");
document.write(".OBs_Class{left:0;width:" + OB_Width + ";height:" + OB_ButtonHeight + ";line-height:2;font-family:" + OB_ButtonFontFamily + ";font-size:" + OB_ButtonFontSize + "pt;cursor:pointer;color:" + OB_ButtonFontColor + "; border-width:0; background-color: #2159DA}");
document.write("</style>");

var OutlookLikeBar = new OutBar(OB_Width, OB_Height, j - 1, OB_ButtonHeight, OB_BorderWidth, OB_SlideSpeed, OB_IconsHeight + OB_LabelFontSize + OB_LabelMargin + OB_ItemsSpacing, OB_ArrowSlideSpeed);
InitBar(OB_BackgroundImg, OB_BackgroundDownImg, OB_BackgroundOverImg, OB_BackgroundOverDownImg);
window.status = ITEM_TITLE;
document.getElementById("OutlookLikeBar").style.visibility = "visible";

function MakeItems(Folder, zorder, top)
{
    var items = 0;
    var folderWidth = (OB_Width - OB_BorderWidth * 2);
    var sfolderWidth = folderWidth - 3;
    while (Folder[items + 1])
        items += 4;
    items /= 4;
    document.write("<DIV id='OB_Folder" + zorder + "' style='FILTER: DropShadow(Color=" + OB_LabelFontShadowColor + ", OffX=1, OffY=1, Positive=1);position:absolute;left:0;top:" + top + ";width:" + folderWidth + ";height:" + (OB_Margin * 2 + items * (OB_IconsHeight + OB_LabelFontSize + OB_LabelMargin) + (items - 1) * OB_ItemsSpacing) + ";z-index:" + zorder + ";clip:rect(0 0 0 0);'  >");
    for (var i = 1; i < items * 4; i += 4)
    {
        document.write("<div align='left' onclick=doSubTag('"+Folder[i+3]+"','"+Folder[i+2]+"') onMouseDown='OutlookLikeBar.ItemClicked(this)' onMouseOver='OutlookLikeBar.OverItems(this)' onMouseOut='OutlookLikeBar.OutItems(this)' style='width:" + sfolderWidth + ";position:absolute;left:0;top:" + (OB_Margin + Math.ceil((i - 1) / 4) * (OB_ItemsSpacing + OB_LabelFontSize + OB_IconsHeight) - 4) + ";cursor:pointer;clip:rect(0 " + OB_IconsWidth + " " + OB_IconsHeight + " 0;width:" + OB_IconsWidth + ";height:" + OB_IconsHeight + "'>");
        document.write("&nbsp;<img align=middle src='" + Folder[i] + "' border=0 hspace=2>");
        document.write("<font style='font-family:" + OB_LabelFontFamily + ";font-size:" + OB_LabelFontSize + "pt;color:" + OB_LabelFontColor + "'>&nbsp;" + Folder[i + 1] + "</font>");
        document.write("</div>");
    }
    document.write("</DIV>");
}

function doSubTag(target,link)
{
	document.getElementById("actform").action = link;
	document.getElementById("actform").target = target;
	document.getElementById("actform").submit();
}


//***************************
//* Outlook-Like Bar Object *
//***************************
function OutBar(width, height, items, buttonHeight, borderWidth, slideSpeed, slideArrowValue, ArrowSlideSpeed)
{
    this.currentFolder = 1;
    this.currentItem = null;
    this.slideCount = 0;
    this.slideStep = 1;
    this.slideArrowValue = slideArrowValue;
    this.slideSpeed = slideSpeed;
    this.borderWidth = borderWidth;
    this.width = width;
    this.visibleAreaHeight = height - 2 * borderWidth - items * buttonHeight;
    this.visibleAreaWidth = width;
    this.FolderClicked = FolderClicked;
    this.SlideFolders = SlideFolders;
    this.ItemClicked = ItemClicked;
    this.OverItems = OverItems;
    this.OutItems = OutItems;
    this.OverArrow = OverArrow;
    this.OutArrow = OutArrow;
    this.ArrowClicked = ArrowClicked;
    this.ArrowSelected = ArrowSelected;
    this.ArrowSlideSpeed = ArrowSlideSpeed;
    this.SlideItems = SlideItems;
    this.SlideItemsAction = SlideItemsAction;
    this.Start = Start;
    this.ClipFolder = ClipFolder;
    this.SetArrows = SetArrows;
    this.HideArrows = HideArrows;
    this.sliding = false;
    this.items = items;
    this.started = false;
    this.Start();
}

function InitBar(img, dimg, oimg, odimg)
{
    var orign = new Array();
    var oldTD = null;
    for (var i = 1; i <= itemNum; i++)
    {
        document.getElementById("OB_Button" + i).cid = Math.ceil((new Date().getTime()) * Math.random());
        if (i == 1) document.getElementById("OB_Button" + i).style.background = 'url(' + dimg + ')';
        else document.getElementById("OB_Button" + i).style.background = 'url(' + img + ')';

        document.getElementById("OB_Button" + i).onmousedown = function()
        {
            this.style.background = 'url(' + dimg + ')';
            orign[this.cid] = this.style.background;
        }
        document.getElementById("OB_Button" + i).onmouseover = function()
        {
            oldTD = this;
            orign[this.cid] = this.style.background;
            if (this.style.background == 'url(' + dimg + ')')
                this.style.background = 'url(' + odimg + ')';
            else this.style.background = 'url(' + oimg + ')';
        }
        document.getElementById("OB_Button" + i).onmouseout = function()
        {
            if (oldTD != null && oldTD.cid == this.cid)
            {
                this.style.background = orign[this.cid];
            }
        }
    }

}

function SetBgimage(folder)
{
    for (var i = 1; i <= itemNum; i++)
    {
        if (i != folder)
        {
            document.getElementById("OB_Button" + i).style.background = 'url(' + OB_BackgroundImg + ')';
        }
    }
}

function FolderClicked(folder)
{
    if (this.sliding)
        return;
    if (folder == this.currentFolder)
        return;
    this.sliding = true;
    this.slideCount = this.visibleAreaHeight;
    this.slideStep = 1;
    this.countStep = 0;
    this.HideArrows();
    this.SlideFolders(folder, document.getElementById("OB_Button" + folder).position == "DOWN");
}

function SlideFolders(folder, down)
{
    var step;
    if (down)
    {
        this.slideCount -= Math.floor(this.slideStep);
        if (this.slideCount < 0)
            this.slideStep += this.slideCount;
        step = Math.floor(this.slideStep);
        for (var i = 2; i <= folder; i++)
            if (document.getElementById("OB_Button" + i).position == "DOWN")
            {
                document.getElementById("OB_Button" + i).style.pixelTop -= step;
                document.getElementById("OB_Folder" + i).style.pixelTop -= step;
            }

        filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;

        var clipString = document.getElementById("OB_Folder" + folder).style.clip;
        var clip = clipString.match(filter);
        this.ClipFolder(folder, parseInt(clip[1]), this.visibleAreaWidth, (parseInt(clip[3]) + step), 0);

        var clipString = document.getElementById("OB_Folder" + this.currentFolder).style.clip;
        var clip = clipString.match(filter);
        this.ClipFolder(this.currentFolder, parseInt(clip[1]), this.visibleAreaWidth, (parseInt(clip[3]) - step), 0);

        this.slideStep *= this.slideSpeed;
        if (this.slideCount > 0)
            setTimeout("OutlookLikeBar.SlideFolders(" + folder + ",true)", 20);
        else
        {
            for (var k = 2; k <= folder; k++)
            {
                document.getElementById("OB_Button" + k).position = "UP";
            }
            this.currentFolder = folder;
            this.SetArrows();
            this.sliding = false;
        }
    }
    else
    {
        this.slideCount -= Math.floor(this.slideStep);
        if (this.slideCount < 0)
            this.slideStep += this.slideCount;
        step = Math.floor(this.slideStep);
        for (var i = folder + 1; i <= this.items; i++)
            if (document.getElementById("OB_Button" + i).position == "UP")
            {
                document.getElementById("OB_Button" + i).style.pixelTop += step;
                document.getElementById("OB_Folder" + i).style.pixelTop += step;

            }

        filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;

        var clipString = document.getElementById("OB_Folder" + folder).style.clip;
        var clip = clipString.match(filter);
        this.ClipFolder(folder, parseInt(clip[1]), this.visibleAreaWidth, (parseInt(clip[3]) + step), 0);

        var clipString = document.getElementById("OB_Folder" + this.currentFolder).style.clip;
        var clip = clipString.match(filter);
        this.ClipFolder(this.currentFolder, parseInt(clip[1]), this.visibleAreaWidth, (parseInt(clip[3]) - step), 0);

        this.slideStep *= this.slideSpeed;
        if (this.slideCount > 0)
            setTimeout("OutlookLikeBar.SlideFolders(" + folder + ",false)", 20);
        else
        {
            for (var k = folder + 1; k <= this.items; k++)
                document.getElementById("OB_Button" + k).position = "DOWN";
            this.currentFolder = folder;
            this.SetArrows();
            this.sliding = false;
        }
    }
}

function ItemClicked(item)
{
    if (this.sliding)
        return;
    item.style.border = "1 inset #ffffff";
}

function OverItems(item)
{
    if (this.sliding)
        return;
    item.style.border = '1px solid #8BA8C6';
    item.style.backgroundColor = '#CEE9FE';
}

function OutItems(item)
{
    if (this.sliding)
        return;
    item.style.border = '0px solid #8BA8C6';
    item.style.backgroundColor = '#FFFFFF';
}

function ArrowClicked(arrow)
{
    if (this.sliding)
        return;
    arrow.style.border = "1 inset #ffffff";
}

function ArrowSelected(arrow)
{
    if (this.sliding)
        return;
    arrow.style.border = "0 none black";
    this.SlideItems(arrow.id == "OB_SlideUp");
}

function OverArrow(arrow)
{
    if (this.sliding)
        return;
    arrow.style.border = "1 outset #ffffff";

    var folder = document.getElementById("OB_Folder" + OutlookLikeBar.currentFolder).style;
    var startTop = document.getElementById("OB_Button" + OutlookLikeBar.currentFolder).style.pixelTop +
     document.getElementById("OB_Button" + OutlookLikeBar.currentFolder).style.pixelHeight;
}

function OutArrow(arrow)
{
    if (this.sliding)
        return;
    arrow.style.border = "0 none black";
}

function ClipFolder(folder, top, right, bottom, left)
{
    document.getElementById("OB_Folder" + folder).style.clip = clip = 'rect(' + top + ' ' + right + ' ' + bottom + ' ' + left + ')';
}

function Start()
{
    if (!this.started)
    {
        this.ClipFolder(1, 0, this.visibleAreaWidth, this.visibleAreaHeight, 0);
        this.SetArrows();
    }
}

function SetArrows()
{
    document.getElementById("OB_SlideUp").style.pixelTop = document.getElementById("OB_Button" + this.currentFolder).style.pixelTop + document.getElementById("OB_Button" + this.currentFolder).style.pixelHeight + this.visibleAreaHeight - document.getElementById("OB_SlideDown").height - 20;
    document.getElementById("OB_SlideUp").style.pixelLeft = this.width - document.getElementById("OB_SlideUp").width - this.borderWidth - 10;
    document.getElementById("OB_SlideDown").style.pixelTop = document.getElementById("OB_Button" + this.currentFolder).style.pixelTop + document.getElementById("OB_Button" + this.currentFolder).style.pixelHeight + 20;
    document.getElementById("OB_SlideDown").style.pixelLeft = this.width - document.getElementById("OB_SlideDown").width - this.borderWidth - 10;

    var folder = document.getElementById("OB_Folder" + this.currentFolder).style;
    var startTop = document.getElementById("OB_Button" + this.currentFolder).style.pixelTop + document.getElementById("OB_Button" + this.currentFolder).style.pixelHeight;

    if (folder.pixelTop < startTop)
        document.getElementById("OB_SlideDown").style.visibility = "visible";
    else
        document.getElementById("OB_SlideDown").style.visibility = "hidden";

    if (folder.pixelHeight - (startTop - folder.pixelTop) > this.visibleAreaHeight)
        document.getElementById("OB_SlideUp").style.visibility = "visible";
    else
        document.getElementById("OB_SlideUp").style.visibility = "hidden";
}

function HideArrows()
{
    document.getElementById("OB_SlideUp").style.visibility = "hidden";
    document.getElementById("OB_SlideDown").style.visibility = "hidden";
}

function SlideItems(up)
{
    this.sliding = true;
    this.slideCount = Math.floor(this.slideArrowValue / this.ArrowSlideSpeed);
    up ? this.SlideItemsAction(-this.ArrowSlideSpeed) : this.SlideItemsAction(this.ArrowSlideSpeed);
}

function SlideItemsAction(value)
{
    document.getElementById("OB_Folder" + this.currentFolder).style.pixelTop += value;
    filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;
    var clipString = document.getElementById("OB_Folder" + this.currentFolder).style.clip;
    var clip = clipString.match(filter); 
    this.ClipFolder(this.currentFolder, (parseInt(clip[1]) - value), parseInt(clip[2]), (parseInt(clip[3]) - value), parseInt(clip[4]));
    this.slideCount--;
    if (this.slideCount > 0)
        setTimeout("OutlookLikeBar.SlideItemsAction(" + value + ")", 20);
    else
    {
        if (Math.abs(value) * this.ArrowSlideSpeed != this.slideArrowValue)
        {
            document.getElementById("OB_Folder" + this.currentFolder).style.pixelTop += (value / Math.abs(value) * (this.slideArrowValue % this.ArrowSlideSpeed));
            filter = /rect\((\d*)px (\d*)px (\d*)px (\d*)px\)/;
            var clipString = document.getElementById("OB_Folder" + this.currentFolder).style.clip;
            var clip = clipString.match(filter);
            this.ClipFolder(this.currentFolder, (parseInt(clip[1]) - (value / Math.abs(value) * (this.slideArrowValue % this.ArrowSlideSpeed))), parseInt(clip[2]), (parseInt(clip[3]) - (value / Math.abs(value) * (this.slideArrowValue % this.ArrowSlideSpeed))), parseInt(clip[4]));
        }
        this.SetArrows();
        this.sliding = false;
    }
}
function Onwheel()
{
    var folder = document.getElementById("OB_Folder" + OutlookLikeBar.currentFolder).style;
    var startTop = document.getElementById("OB_Button" + OutlookLikeBar.currentFolder).style.pixelTop + document.getElementById("OB_Button" + OutlookLikeBar.currentFolder).style.pixelHeight;
    if (event.wheelDelta >= 120 && folder.pixelTop < startTop)
    {
        OutlookLikeBar.ArrowSelected(OB_SlideDown);
    }
    else if (event.wheelDelta <= -120 && folder.pixelHeight - (startTop - folder.pixelTop) > OutlookLikeBar.visibleAreaHeight)
    {
        OutlookLikeBar.ArrowSelected(OB_SlideUp);
    }
}