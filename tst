package {
    import flash.display.*;
    import flash.text.*;

    public dynamic class AdvertPlayerCore extends MovieClip {

        public var adv_pic:MovieClip;
        public var adv_mask:MovieClip;
        public var hint_ad_text:TextField;
        public var hint_ad_bg:MovieClip;
        public var hint_ad_close:SimpleButton;
        public var hint_ad_url:TextField;

    }
}//package 
﻿package classes {
    import flash.display.*;
    import flash.events.*;

    public class Preloader extends MovieClip {

        private static const ENTRY_FRAME:int = 1;

        public function Preloader():void{
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            addEventListener(Event.ENTER_FRAME, this.checkFrame);
            loaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progress);
            loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, this.ioError);
        }
        private function ioError(_arg1:IOErrorEvent):void{
        }
        private function progress(_arg1:ProgressEvent):void{
        }
        private function checkFrame(_arg1:Event):void{
            if (currentFrame == totalFrames){
                stop();
                this.loadingFinished();
            };
        }
        private function loadingFinished():void{
            removeEventListener(Event.ENTER_FRAME, this.checkFrame);
            loaderInfo.removeEventListener(ProgressEvent.PROGRESS, this.progress);
            loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, this.ioError);
            this.startup();
        }
        private function startup():void{
            var _local1:DisplayObject = (new Main() as DisplayObject);
            addChild(_local1);
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class ReadVASTXML {

        private var mc_main:MovieClip;
        private var xml:XML;
        private var xml_request:URLRequest;
        private var xml_loader:URLLoader;
        private var xml_path:String;
        private var i;
        private var j:uint;
        private var Track:String;

        public function ReadVASTXML(_arg1:MovieClip){
            this.xml = new XML();
            super();
            this.mc_main = _arg1;
        }
        public function configVASTXML(_arg1:String):void{
            this.xml = new XML();
            this.xml_path = ((_arg1 + "?") + Math.random());
            trace(("xml_path = " + this.xml_path));
            this.xml_request = new URLRequest(this.xml_path);
            this.xml_loader = new URLLoader(this.xml_request);
            this.xml.ignoreComments = true;
            this.xml.ignoreWhitespace = true;
            this.xml_loader.addEventListener(ProgressEvent.PROGRESS, this.onLoadProgressXML);
            this.xml_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadErrorXML);
            this.xml_loader.addEventListener(Event.COMPLETE, this.OnLoadCompleteXML);
        }
        private function onLoadProgressXML(_arg1:ProgressEvent):void{
        }
        private function onLoadErrorXML(_arg1:IOErrorEvent):void{
            this.mc_main.log(("XML VAST error " + _arg1.text), this.mc_main.CONSOLE);
        }
        private function OnLoadCompleteXML(_arg1:Event):void{
            var _local2:URLLoader = URLLoader(_arg1.target);
            this.xml = XML(_local2.data);
            if (this.xml.hasOwnProperty("Ad")){
                if (this.xml.Ad.hasOwnProperty("InLine")){
                    if (this.xml.Ad.InLine.hasOwnProperty("Creatives")){
                        if (this.xml.Ad.InLine.Creatives.hasOwnProperty("Creative")){
                            if (this.xml.Ad.InLine.Creatives.Creative.hasOwnProperty("Linear")){
                                if (this.xml.Ad.InLine.Creatives.Creative.Linear.hasOwnProperty("TrackingEvents")){
                                    this.i = 0;
                                    while (this.i < this.xml.Ad.InLine.Creatives.Creative.Linear.TrackingEvents.Tracking.length()) {
                                        this.Track = this.xml.Ad.InLine.Creatives.Creative.Linear.TrackingEvents.Tracking[this.i].@event;
                                        switch (this.Track){
                                            case "start":
                                                break;
                                            case "midpoint":
                                                break;
                                            case "complete":
                                                break;
                                            case "pause":
                                                break;
                                            case "resume":
                                                break;
                                            case "mute":
                                                break;
                                            case "unmute":
                                                break;
                                            case "firstQuartile":
                                                break;
                                            case "thirdQuartile":
                                                break;
                                            case "replay":
                                                break;
                                            case "fullscreen":
                                                break;
                                            case "stop":
                                                break;
                                        };
                                        this.i++;
                                    };
                                };
                                if (this.xml.Ad.InLine.Creatives.Creative.Linear.hasOwnProperty("VideoClicks")){
                                    this.mc_main.player_preroll_vastfile_url = this.xml.Ad.InLine.Creatives.Creative.Linear.VideoClicks.ClickThrough.toString();
                                };
                                if (this.xml.Ad.InLine.Creatives.Creative.Linear.hasOwnProperty("MediaFiles")){
                                    this.mc_main.player_preroll_vastfile_width = this.xml.Ad.InLine.Creatives.Creative.Linear.MediaFiles.MediaFile.@width.toString();
                                    this.mc_main.player_preroll_vastfile_hight = this.xml.Ad.InLine.Creatives.Creative.Linear.MediaFiles.MediaFile.@height.toString();
                                    this.mc_main.player_preroll_vastfile = this.xml.Ad.InLine.Creatives.Creative.Linear.MediaFiles.MediaFile.toString();
                                };
                            };
                        };
                    };
                };
            };
            this.mc_main.playerUIAdvert();
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;

    public class Main extends Sprite {

        private var vid:TvForsitePlayer;
        private var naga:Sprite;
        private var loader:Loader;

        public function Main():void{
            if (stage){
                this.init();
            } else {
                addEventListener(Event.ADDED_TO_STAGE, this.init);
            };
        }
        private function init(_arg1:Event=null):void{
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            this.vid = new TvForsitePlayer();
            addChild(this.vid);
            var _local2:String = (((stage.loaderInfo.parameters.userid == null)) ? "1" : stage.loaderInfo.parameters.userid);
            var _local3:String = (((stage.loaderInfo.parameters.videoid == null)) ? "2" : stage.loaderInfo.parameters.videoid);
            var _local4:String = (((stage.loaderInfo.parameters.videotype == null)) ? "stream" : stage.loaderInfo.parameters.videotype);
            var _local5:String = (((stage.loaderInfo.parameters.sessid == null)) ? "3" : stage.loaderInfo.parameters.sessid);
            this.vid.sortUI(_local2, _local3, _local4, _local5);
        }

    }
}//package classes 
﻿package classes {
    import flash.net.*;

    public class SaveVolume {

        private var so:SharedObject;

        public function SaveVolume(){
            this.Settings();
        }
        function Settings(){
            this.so = SharedObject.getLocal("TvForsitePlayer");
        }
        function setLevelVolume(_arg1:Number){
            this.so.data["level_volume"] = _arg1;
            this.so.flush();
        }
        function getLevelVolume():Number{
            return ((Number(this.so.data["level_volume"]) * 1));
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import com.greensock.*;
    import flash.net.*;
    import com.greensock.easing.*;
    import flash.media.*;
    import flash.utils.*;
    import flash.system.*;

    public class Related extends MovieClip {

        private const DEFAULT_SLIDER_WIDTH:Number = 520;

        private var core:RelatedPlayerCore;
        public var label:TextField;
        private var related_left:MovieClip;
        private var related_right:MovieClip;
        private var maska:MovieClip;
        private var related_slider:MovieClip;
        private var mc_conteiner:MovieClip;
        private var rows:Array;
        private var step:Number = 0;
        private var curNum:Number = 1;
        private var countNum:Number;
        private var i:int = 0;

        public function Related():void{
            this.initRelatedUI();
        }
        public function initRelatedUI():void{
            this.core = new RelatedPlayerCore();
            addChild(this.core);
            this.core.visible = false;
            this.related_left = this.core.related_left;
            this.related_right = this.core.related_right;
            this.maska = this.core.maska;
            this.related_slider = this.core.related_slider;
            this.mc_conteiner = this.core.mc_conteiner;
        }
        public function sortRelatedUI(_arg1, _arg2, _arg3, _arg4):void{
            this.mc_conteiner.visible = false;
            this.related_slider.mask = this.maska;
            this.rows = _arg1;
            if (_arg1.length > 0){
                this.createRelated(_arg1, _arg2, _arg3, _arg4);
                this.countNum = Math.ceil((this.related_slider.width / this.DEFAULT_SLIDER_WIDTH));
                this.visibleRelateButton();
            } else {
                this.related_left.visible = false;
                this.related_right.visible = false;
            };
            this.related_left.buttonMode = true;
            this.related_left.addEventListener(MouseEvent.CLICK, this.clickRelatedRight);
            this.related_right.buttonMode = true;
            this.related_right.addEventListener(MouseEvent.CLICK, this.clickRelatedLeft);
        }
        private function clickRelatedLeft(_arg1:MouseEvent):void{
            var _local2:Number = (this.step - this.DEFAULT_SLIDER_WIDTH);
            if ((_local2 * -1) < this.related_slider.width){
                this.step = _local2;
                this.curNum++;
                this.visibleRelateButton();
                TweenMax.to(this.related_slider, 0.5, {
                    x:this.step,
                    ease:Cubic.easeOut
                });
            };
        }
        private function clickRelatedRight(_arg1:MouseEvent):void{
            var _local2:Number = (this.step + this.DEFAULT_SLIDER_WIDTH);
            if (_local2 <= 5){
                this.step = _local2;
                this.curNum--;
                this.visibleRelateButton();
                TweenMax.to(this.related_slider, 0.5, {
                    x:this.step,
                    ease:Cubic.easeOut
                });
            };
        }
        private function visibleRelateButton():void{
            if (this.rows.length > 0){
                if (this.curNum == this.countNum){
                    if (this.countNum == 1){
                        this.related_left.visible = false;
                        this.related_right.visible = false;
                    } else {
                        this.related_left.visible = true;
                        this.related_right.visible = false;
                    };
                } else {
                    if (this.curNum == 1){
                        if (this.countNum == 1){
                            this.related_right.visible = false;
                            this.related_left.visible = false;
                        } else {
                            this.related_right.visible = true;
                            this.related_left.visible = false;
                        };
                    } else {
                        if (((!((this.curNum == 1))) || (!((this.curNum == this.countNum))))){
                            this.related_right.visible = true;
                            this.related_left.visible = true;
                        };
                    };
                };
            };
        }
        public function createRelated(_arg1, _arg2, _arg3, _arg4):void{
            var row_pic:* = _arg1;
            var row_url:* = _arg2;
            var row_title:* = _arg3;
            var row_text:* = _arg4;
            while (this.i < row_pic.length) {
                var click:* = function (_arg1:MouseEvent):void{
                    requestURL(_arg1.target.parent.link);
                };
                var rolOver:* = function (_arg1:MouseEvent):void{
                    _arg1.target.mc_shade.visible = true;
                };
                var rolOut:* = function (_arg1:MouseEvent):void{
                    _arg1.target.mc_shade.visible = false;
                };
                this.related_slider[("related_slider" + this.i)] = new m_conteiner();
                this.related_slider[("related_slider" + this.i)].num = this.i;
                this.related_slider[("related_slider" + this.i)].mc_shade.visible = false;
                this.related_slider[("related_slider" + this.i)].mc_activity.visible = false;
                this.related_slider[("related_slider" + this.i)].link = row_url[this.i];
                this.related_slider[("related_slider" + this.i)].t1.htmlText = row_title[this.i];
                this.related_slider[("related_slider" + this.i)].t1.mouseEnabled = false;
                this.related_slider[("related_slider" + this.i)].t2.htmlText = row_text[this.i];
                this.related_slider[("related_slider" + this.i)].t2.mouseEnabled = false;
                this.related_slider[("related_slider" + this.i)].x = ((this.i * 130) + 45);
                this.related_slider[("related_slider" + this.i)].y = 0;
                this.related_slider[("related_slider" + this.i)].buttonMode = true;
                this.related_slider[("related_slider" + this.i)].addEventListener(MouseEvent.CLICK, click);
                this.related_slider[("related_slider" + this.i)].addEventListener(MouseEvent.ROLL_OVER, rolOver);
                this.related_slider[("related_slider" + this.i)].addEventListener(MouseEvent.ROLL_OUT, rolOut);
                this.related_slider.addChild(this.related_slider[("related_slider" + this.i)]);
                this.loadImages(row_pic[this.i], this.i);
            };
        }
        private function loadImages(_arg1, _arg2):void{
            var picLoader:* = null;
            var ioError:* = null;
            var onLoadProgress:* = null;
            var onLoadComplete:* = null;
            var url:* = _arg1;
            var j:* = _arg2;
            ioError = function (_arg1:IOErrorEvent):void{
            };
            onLoadProgress = function (_arg1:ProgressEvent):void{
                related_slider[("related_slider" + j)].mc_activity.visible = true;
            };
            onLoadComplete = function (_arg1:Event):void{
                picLoader.content.width = mc_conteiner.mc_img.width;
                picLoader.content.height = mc_conteiner.mc_img.height;
                related_slider[("related_slider" + j)].mc_activity.visible = false;
                related_slider[("related_slider" + j)].mc_shade.width = picLoader.content.width;
                related_slider[("related_slider" + j)].mc_shade.height = picLoader.content.height;
                related_slider[("related_slider" + j)].mc_img.addChild(picLoader.content);
            };
            var picURL:* = new URLRequest(url);
            picLoader = new Loader();
            picLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
            picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
            picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            var loaderContext:* = new LoaderContext();
            loaderContext.checkPolicyFile = true;
            if (Security.sandboxType != "localTrusted"){
                loaderContext.applicationDomain = ApplicationDomain.currentDomain;
                loaderContext.securityDomain = SecurityDomain.currentDomain;
            };
            picLoader.load(picURL, loaderContext);
            this.i++;
        }
        private function requestURL(_arg1){
            var _local2:URLRequest = new URLRequest(_arg1);
            try {
                navigateToURL(_local2, "_blank");
            } catch(e:Error) {
            };
        }
        public function hideRelated():void{
            this.core.visible = false;
            this.curNum = 1;
            this.step = 0;
            this.visibleRelateButton();
            this.related_slider.x = 0;
        }
        public function seeRelated():void{
            this.core.visible = true;
        }
        public function resizeRelated():void{
            this.core.x = ((stage.stageWidth / 2) - 300);
            if (stage.displayState == StageDisplayState.NORMAL){
                this.core.y = ((stage.stageHeight - this.core.height) - 30);
            } else {
                this.core.y = ((stage.stageHeight - this.core.height) - 50);
            };
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class ReadXML {

        private var mc_main:MovieClip;
        private var xml:XML;
        private var xml_request:URLRequest;
        private var xml_loader:URLLoader;
        private var xml_path:String;
        private var i;
        private var j:uint;

        public function ReadXML(_arg1:MovieClip){
            this.xml = new XML();
            super();
            this.mc_main = _arg1;
        }
        public function configXML(_arg1:String):void{
            this.xml = new XML();
            switch (this.mc_main.videotype){
                case "file":
                    this.xml_path = ("file.xml?" + Math.random());
                    this.xml_path = "file.xml";
                    break;
                case "stream":
                    this.xml_path = ("stream.xml?" + Math.random());
                    this.xml_path = "stream.xml";
                    this.xml_path = "p2p.xml";
                    break;
            };
            this.xml_path = ((_arg1 + "&") + Math.random());
            trace(("xml_path = " + this.xml_path));
            this.xml_request = new URLRequest(this.xml_path);
            this.xml_loader = new URLLoader(this.xml_request);
            this.xml.ignoreComments = true;
            this.xml.ignoreWhitespace = true;
            this.xml_loader.addEventListener(ProgressEvent.PROGRESS, this.onLoadProgressXML);
            this.xml_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadErrorXML);
            this.xml_loader.addEventListener(Event.COMPLETE, this.OnLoadCompleteXML);
        }
        private function onLoadProgressXML(_arg1:ProgressEvent):void{
        }
        private function onLoadErrorXML(_arg1:IOErrorEvent):void{
            this.mc_main.log(("XML error " + _arg1.text), this.mc_main.CONSOLE);
        }
        private function OnLoadCompleteXML(_arg1:Event):void{
            var _local2:URLLoader = URLLoader(_arg1.target);
            this.xml = XML(_local2.data);
            switch (this.mc_main.videotype){
                case "file":
                    this.mc_main.xml_autostart = this.xml.@autostart.toString();
                    this.mc_main.xml_buffertime = this.xml.@buffertime.toString();
                    this.mc_main.xml_type_sd = this.xml.@type_sd.toString();
                    this.mc_main.xml_type_hd = this.xml.@type_hd.toString();
                    this.mc_main.xml_thumb = this.xml.@thumb.toString();
                    this.mc_main.xml_thumb_url = this.xml.@thumb_url.toString();
                    this.mc_main.xml_name = this.xml.@name.toString();
                    this.mc_main.xml_hide_panel = this.xml.@hide_panel.toString();
                    this.mc_main.xml_filesd = this.xml.@filesd.toString();
                    this.mc_main.xml_filehd = this.xml.@filehd.toString();
                    this.mc_main.xml_file_screencast = this.xml.@file_screencast.toString();
                    this.mc_main.xml_num_screencast = this.xml.@num_screencast.toString();
                    this.mc_main.xml_file_screencast_size = this.xml.@file_screencast_size.toString();
                    this.mc_main.xml_link = this.xml.@link.toString();
                    this.mc_main.xml_code = this.xml.@code.toString();
                    this.mc_main.xml_blog = this.xml.@blog.toString();
                    this.mc_main.xml_logo = this.xml.@logo.toString();
                    this.mc_main.xml_logo_url = this.xml.@logo_url.toString();
                    this.mc_main.xml_logo_position = this.xml.@logo_position.toString();
                    this.mc_main.xml_cl_setting = this.xml.@cl_setting.toString();
                    this.mc_main.xml_cl_url = this.xml.@cl_url.toString();
                    this.i = 0;
                    while (this.i < this.xml.children().length()) {
                        switch (this.xml.children()[this.i].name().toString()){
                            case "image":
                                this.j = 0;
                                while (this.j < this.xml.children()[this.i].children().length()) {
                                    this.mc_main.row_pic.push(this.xml.children()[this.i].image[this.j].@pic.toString());
                                    this.mc_main.row_url.push(this.xml.children()[this.i].image[this.j].@url.toString());
                                    this.mc_main.row_title.push(this.xml.children()[this.i].image[this.j].@title.toString());
                                    this.mc_main.row_text.push(this.xml.children()[this.i].image[this.j].@text.toString());
                                    this.j++;
                                };
                                break;
                            case "syte":
                                this.j = 0;
                                while (this.j < this.xml.children()[this.i].children().length()) {
                                    this.mc_main.syte_pic.push(this.xml.children()[this.i].syte[this.j].@pic.toString());
                                    this.mc_main.syte_url.push(this.xml.children()[this.i].syte[this.j].@url.toString());
                                    this.j++;
                                };
                                break;
                        };
                        this.i++;
                    };
                    break;
                case "stream":
                    this.mc_main.xml_autostart = this.xml.@autostart.toString();
                    this.mc_main.xml_buffertime = this.xml.@buffertime.toString();
                    this.mc_main.xml_type_sd = this.xml.@type_sd.toString();
                    this.mc_main.xml_type_hd = this.xml.@type_hd.toString();
                    this.mc_main.xml_group_sd = this.xml.@group_sd.toString();
                    this.mc_main.xml_group_hd = this.xml.@group_hd.toString();
                    this.mc_main.xml_thumb = this.xml.@thumb.toString();
                    this.mc_main.xml_thumb_url = this.xml.@thumb_url.toString();
                    this.mc_main.xml_name = this.xml.@name.toString();
                    this.mc_main.xml_hide_panel = this.xml.@hide_panel.toString();
                    this.mc_main.xml_stream_sd = this.xml.@stream_sd.toString();
                    this.mc_main.xml_stream_hd = this.xml.@stream_hd.toString();
                    this.mc_main.xml_chanel_sd = this.xml.@chanel_sd.toString();
                    this.mc_main.xml_chanel_hd = this.xml.@chanel_hd.toString();
                    this.mc_main.xml_stream_sd_height = this.xml.@stream_sd_height.toString();
                    this.mc_main.xml_stream_hd_height = this.xml.@stream_hd_height.toString();
                    this.mc_main.xml_stream_sd_width = this.xml.@stream_sd_width.toString();
                    this.mc_main.xml_stream_hd_width = this.xml.@stream_hd_width.toString();
                    this.mc_main.xml_file_screencast = "";
                    this.mc_main.xml_num_screencast = "";
                    this.mc_main.xml_file_screencast_size = "";
                    this.mc_main.xml_link = this.xml.@link.toString();
                    this.mc_main.xml_code = this.xml.@code.toString();
                    this.mc_main.xml_blog = this.xml.@blog.toString();
                    this.mc_main.xml_logo = this.xml.@logo.toString();
                    this.mc_main.xml_ptext = this.xml.@ptext.toString();
                    this.mc_main.xml_logo_url = this.xml.@logo_url.toString();
                    this.mc_main.xml_logo_position = this.xml.@logo_position.toString();
                    this.mc_main.xml_cl_setting = this.xml.@cl_setting.toString();
                    this.mc_main.xml_cl_url = this.xml.@cl_url.toString();
                    this.i = 0;
                    while (this.i < this.xml.children().length()) {
                        switch (this.xml.children()[this.i].name().toString()){
                            case "syte":
                                this.j = 0;
                                while (this.j < this.xml.children()[this.i].children().length()) {
                                    this.mc_main.syte_pic.push(this.xml.children()[this.i].syte[this.j].@pic.toString());
                                    this.mc_main.syte_url.push(this.xml.children()[this.i].syte[this.j].@url.toString());
                                    this.j++;
                                };
                                break;
                        };
                        this.i++;
                    };
                    break;
            };
            this.mc_main.playerUI();
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import com.greensock.*;
    import flash.net.*;
    import com.greensock.easing.*;
    import flash.media.*;
    import flash.utils.*;

    public class Advert2 extends MovieClip {

        private var advertShow:Timer;
        private var advertHide:Timer;
        private var loader:Loader;
        private var advert_mode:String;
        private var advert_url:String;
        private var advert_name:String;
        private var advert_visible:String;
        private var isTimerTick:Boolean = false;
        private var core:Advert2PlayerCore;
        private var hint_ad_url:TextField;
        private var hint_ad_text:TextField;
        private var hint_ad_close:SimpleButton;
        private var adv_pic:MovieClip;
        private var hint_ad_bg:MovieClip;
        private var mask_mc:Shape;

        public function Advert2():void{
            this.initAdvertUI();
        }
        public function initAdvertUI():void{
            this.core = new Advert2PlayerCore();
            addChild(this.core);
            this.core.visible = false;
            this.hint_ad_url = this.core.hint_ad_url;
            this.hint_ad_text = this.core.hint_ad_text;
            this.hint_ad_close = this.core.hint_ad_close;
            this.hint_ad_bg = this.core.hint_ad_bg;
            this.adv_pic = this.core.adv_pic;
        }
        public function sortAdvertUI(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8, _arg9):void{
            this.hint_ad_url.mouseEnabled = false;
            this.hint_ad_text.mouseEnabled = false;
            this.hint_ad_bg.buttonMode = true;
            this.adv_pic.buttonMode = true;
            this.advert_mode = _arg4;
            this.advert_url = _arg2;
            this.advert_name = _arg8;
            this.advert_visible = _arg9;
            this.hint_ad_url.htmlText = _arg6;
            this.hint_ad_text.htmlText = _arg7;
            if (_arg8 == "1"){
                this.core.x = -150;
            } else {
                this.core.x = (stage.stageWidth + 100);
            };
            if (_arg1 == ""){
                this.adv_pic.visible = false;
                this.hint_ad_url.visible = true;
                this.hint_ad_text.visible = true;
            } else {
                this.loadThumb(_arg1);
                this.adv_pic.visible = true;
                this.hint_ad_url.visible = false;
                this.hint_ad_text.visible = false;
            };
            this.advertShow = new Timer(1000, _arg3);
            this.advertHide = new Timer(1000, _arg5);
            this.advertShow.addEventListener(TimerEvent.TIMER, this.advertShowOnTick);
            this.advertShow.addEventListener(TimerEvent.TIMER_COMPLETE, this.advertShowOnTimerComplete);
            this.advertHide.addEventListener(TimerEvent.TIMER, this.advertHideOnTick);
            this.advertHide.addEventListener(TimerEvent.TIMER_COMPLETE, this.advertHideOnTimerComplete);
            this.hint_ad_close.addEventListener(MouseEvent.CLICK, this.closeAdvert);
            this.hint_ad_bg.addEventListener(MouseEvent.CLICK, this.clickAdvert);
            this.adv_pic.addEventListener(MouseEvent.CLICK, this.clickAdvert);
            this.core.visible = true;
        }
        private function loadThumb(_arg1:String):void{
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadThumb);
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressThumb);
            this.loader.load(new URLRequest(_arg1));
        }
        private function progressThumb(_arg1:ProgressEvent):void{
        }
        private function onLoadThumb(_arg1:Event):void{
            var _local2:Number = (this.loader.height / this.loader.width);
            this.loader.width = 486;
            this.loader.height = (486 * _local2);
            this.adv_pic.addChild(this.loader);
        }
        private function clickAdvert(_arg1:MouseEvent):void{
            this.requestURL(this.advert_url);
        }
        private function requestURL(_arg1):void{
            var _local2:URLRequest = new URLRequest(_arg1);
            try {
                navigateToURL(_local2, "_blank");
            } catch(e) {
            };
        }
        public function startTimerShow():void{
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "2":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "3":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
            };
        }
        public function stopTimerShow():void{
            this.advertShow.reset();
            this.advertShow.stop();
            this.advertHide.reset();
            this.advertHide.stop();
            if (this.advert_name == "1"){
                this.core.x = -150;
            } else {
                this.core.x = (stage.stageWidth + 150);
            };
            this.isTimerTick = false;
        }
        public function hideAdvert():void{
            if (this.advert_name == "1"){
                this.core.x = -150;
            } else {
                this.core.x = (stage.stageWidth + 150);
            };
            this.isTimerTick = false;
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "2":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "3":
                    break;
            };
        }
        private function closeAdvert(_arg1:MouseEvent):void{
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertHide.stop();
                    this.hideAdvert();
                    break;
                case "2":
                    this.advertHide.stop();
                    if (this.advert_name == "1"){
                        this.core.x = -150;
                    } else {
                        this.core.x = (stage.stageWidth + 150);
                    };
                    this.isTimerTick = false;
                    break;
                case "3":
                    this.advertHide.stop();
                    this.hideAdvert();
                    break;
            };
        }
        private function advertShowOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function advertShowOnTimerComplete(_arg1:TimerEvent):void{
            if (this.advert_visible == "1"){
                if (this.advert_name == "1"){
                    this.core.x = 0;
                } else {
                    this.core.x = (stage.stageWidth - 140);
                };
                this.advertHide.reset();
                this.advertHide.start();
                this.isTimerTick = true;
            };
        }
        private function advertHideOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function advertHideOnTimerComplete(_arg1:TimerEvent):void{
            this.hideAdvert();
        }
        private function createMask(_arg1):void{
            this.mask_mc = new Shape();
            addChild(this.mask_mc);
            this.mask_mc.graphics.beginFill(0xFFFFFF, 1);
            this.mask_mc.graphics.lineStyle(0, 0, 0);
            this.mask_mc.graphics.moveTo(0, 0);
            this.mask_mc.graphics.lineTo(stage.stageWidth, 0);
            this.mask_mc.graphics.lineTo(stage.stageWidth, (stage.stageHeight - 33));
            this.mask_mc.graphics.lineTo(0, (stage.stageHeight - 33));
            this.mask_mc.graphics.lineTo(0, 0);
            this.mask_mc.graphics.endFill();
            _arg1.mask = this.mask_mc;
        }
        public function resizeAdvert():void{
            if (this.isTimerTick){
                if (this.advert_name == "1"){
                    this.core.x = 0;
                } else {
                    this.core.x = (stage.stageWidth - 140);
                };
            } else {
                if (this.advert_name == "1"){
                    this.core.x = -150;
                } else {
                    this.core.x = (stage.stageWidth + 150);
                };
            };
            this.core.y = ((stage.stageHeight / 2) - (this.core.height / 2));
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;

    public class ReadAdvertXML {

        private var mc_main:MovieClip;
        private var xml:XML;
        private var xml_request:URLRequest;
        private var xml_loader:URLLoader;
        private var xml_path:String;
        private var j:uint;

        public function ReadAdvertXML(_arg1:MovieClip){
            this.xml = new XML();
            super();
            this.mc_main = _arg1;
        }
        public function configXML(_arg1:String):void{
            this.xml = new XML();
            this.xml_path = "Advert.xml";
            this.xml_path = ((_arg1 + "&") + Math.random());
            trace(("xml_path = " + this.xml_path));
            this.xml_request = new URLRequest(this.xml_path);
            this.xml_loader = new URLLoader(this.xml_request);
            this.xml.ignoreComments = true;
            this.xml.ignoreWhitespace = true;
            this.xml_loader.addEventListener(ProgressEvent.PROGRESS, this.onLoadProgressXML);
            this.xml_loader.addEventListener(IOErrorEvent.IO_ERROR, this.onLoadErrorXML);
            this.xml_loader.addEventListener(Event.COMPLETE, this.OnLoadCompleteXML);
        }
        private function onLoadProgressXML(_arg1:ProgressEvent):void{
        }
        private function onLoadErrorXML(_arg1:IOErrorEvent):void{
            this.mc_main.log(("XML advert error " + _arg1.text), this.mc_main.CONSOLE);
        }
        private function OnLoadCompleteXML(_arg1:Event):void{
            var _local2:URLLoader = URLLoader(_arg1.target);
            this.xml = XML(_local2.data);
            if (this.xml.attribute("preroll").toString() != ""){
                this.mc_main.player_preroll = this.xml.attribute("preroll").toString();
            };
            if (this.xml.attribute("urlvideopulse").toString() != ""){
                this.mc_main.player_urlvideopulse = this.xml.attribute("urlvideopulse").toString();
            };
            if (this.mc_main.player_preroll == 2){
                this.mc_main.XMLVAST.configVASTXML(this.mc_main.player_urlvideopulse);
            };
            if (this.xml.attribute("preroll_file").toString() != ""){
                this.mc_main.player_preroll_file = this.xml.attribute("preroll_file").toString();
            };
            if (this.xml.attribute("preroll_url").toString() != ""){
                this.mc_main.player_preroll_url = this.xml.attribute("preroll_url").toString();
            };
            this.mc_main.advert_top_mode = null;
            this.mc_main.advert_bottom_mode = null;
            this.mc_main.advert_left_mode = null;
            this.mc_main.advert_right_mode = null;
            var _local3:uint;
            while (_local3 < this.xml.children().length()) {
                switch (this.xml.children()[_local3].name().toString()){
                    case "advert_top":
                        this.mc_main.advert_top_pic = this.xml.children()[_local3].attribute("advert_pic").toString();
                        this.mc_main.advert_top_url = this.xml.children()[_local3].attribute("advert_url_txt").toString();
                        this.mc_main.advert_top_show = this.xml.children()[_local3].attribute("advert_show").toString();
                        this.mc_main.advert_top_mode = this.xml.children()[_local3].attribute("advert_mode").toString();
                        this.mc_main.advert_top_hide = this.xml.children()[_local3].attribute("advert_hide").toString();
                        this.mc_main.advert_top_title = this.xml.children()[_local3].attribute("advert_title").toString();
                        this.mc_main.advert_top_text = this.xml.children()[_local3].attribute("advert_text").toString();
                        break;
                    case "advert_bottom":
                        this.mc_main.advert_bottom_pic = this.xml.children()[_local3].attribute("advert_pic").toString();
                        this.mc_main.advert_bottom_url = this.xml.children()[_local3].attribute("advert_url_txt").toString();
                        this.mc_main.advert_bottom_show = this.xml.children()[_local3].attribute("advert_show").toString();
                        this.mc_main.advert_bottom_mode = this.xml.children()[_local3].attribute("advert_mode").toString();
                        this.mc_main.advert_bottom_hide = this.xml.children()[_local3].attribute("advert_hide").toString();
                        this.mc_main.advert_bottom_title = this.xml.children()[_local3].attribute("advert_title").toString();
                        this.mc_main.advert_bottom_text = this.xml.children()[_local3].attribute("advert_text").toString();
                        break;
                    case "advert_left":
                        this.mc_main.advert_left_pic = this.xml.children()[_local3].attribute("advert_pic").toString();
                        this.mc_main.advert_left_url = this.xml.children()[_local3].attribute("advert_url_txt").toString();
                        this.mc_main.advert_left_show = this.xml.children()[_local3].attribute("advert_show").toString();
                        this.mc_main.advert_left_mode = this.xml.children()[_local3].attribute("advert_mode").toString();
                        this.mc_main.advert_left_hide = this.xml.children()[_local3].attribute("advert_hide").toString();
                        this.mc_main.advert_left_title = this.xml.children()[_local3].attribute("advert_title").toString();
                        this.mc_main.advert_left_text = this.xml.children()[_local3].attribute("advert_text").toString();
                        break;
                    case "advert_right":
                        this.mc_main.advert_right_pic = this.xml.children()[_local3].attribute("advert_pic").toString();
                        this.mc_main.advert_right_url = this.xml.children()[_local3].attribute("advert_url_txt").toString();
                        this.mc_main.advert_right_show = this.xml.children()[_local3].attribute("advert_show").toString();
                        this.mc_main.advert_right_mode = this.xml.children()[_local3].attribute("advert_mode").toString();
                        this.mc_main.advert_right_hide = this.xml.children()[_local3].attribute("advert_hide").toString();
                        this.mc_main.advert_right_title = this.xml.children()[_local3].attribute("advert_title").toString();
                        this.mc_main.advert_right_text = this.xml.children()[_local3].attribute("advert_text").toString();
                        break;
                };
                _local3++;
            };
            if (this.mc_main.player_preroll != 2){
                this.mc_main.playerUIAdvert();
            };
        }

    }
}//package classes 
﻿package classes {

    public class TEA {

        public static function encrypt(_arg1:String, _arg2:String):String{
            var _local9:Number;
            var _local10:Number;
            var _local14:*;
            if (_arg1.length == 0){
                return ("");
            };
            var _local3:Array = charsToLongs(strToChars(_arg1));
            if (_local3.length <= 1){
                _local3[1] = 0;
            };
            var _local4:Array = charsToLongs(strToChars(_arg2.substr(0, 16)));
            var _local5:Number = _local3.length;
            var _local6:Number = _local3[(_local5 - 1)];
            var _local7:Number = _local3[0];
            var _local8:Number = 2654435769;
            var _local11:Number = Math.floor((6 + (52 / _local5)));
            var _local12:Number = 0;
            while (_local11-- > 0) {
                _local12 = (_local12 + _local8);
                _local10 = ((_local12 >>> 2) & 3);
                _local14 = 0;
                while (_local14 < _local5) {
                    _local7 = _local3[((_local14 + 1) % _local5)];
                    _local9 = ((((_local6 >>> 5) ^ (_local7 << 2)) + ((_local7 >>> 3) ^ (_local6 << 4))) ^ ((_local12 ^ _local7) + (_local4[((_local14 & 3) ^ _local10)] ^ _local6)));
                    _local6 = (_local3[_local14] = (_local3[_local14] + _local9));
                    _local14++;
                };
            };
            var _local13:Array = longsToChars(_local3);
            return (charsToHex(_local13));
        }
        public static function decrypt(_arg1:String, _arg2:String):String{
            var _local9:Number;
            var _local10:Number;
            var _local14:*;
            if (_arg1.length == 0){
                return ("");
            };
            var _local3:Array = charsToLongs(hexToChars(_arg1));
            var _local4:Array = charsToLongs(strToChars(_arg2.substr(0, 16)));
            var _local5:Number = _local3.length;
            var _local6:Number = _local3[(_local5 - 1)];
            var _local7:Number = _local3[0];
            var _local8:Number = 2654435769;
            var _local11:Number = Math.floor((6 + (52 / _local5)));
            var _local12:Number = (_local11 * _local8);
            while (_local12 != 0) {
                _local10 = ((_local12 >>> 2) & 3);
                _local14 = (_local5 - 1);
                while (_local14 >= 0) {
                    _local6 = _local3[(((_local14 > 0)) ? (_local14 - 1) : (_local5 - 1))];
                    _local9 = ((((_local6 >>> 5) ^ (_local7 << 2)) + ((_local7 >>> 3) ^ (_local6 << 4))) ^ ((_local12 ^ _local7) + (_local4[((_local14 & 3) ^ _local10)] ^ _local6)));
                    _local7 = (_local3[_local14] = (_local3[_local14] - _local9));
                    _local14--;
                };
                _local12 = (_local12 - _local8);
            };
            var _local13:Array = longsToChars(_local3);
            return (charsToStr(_local13));
        }
        private static function charsToLongs(_arg1:Array):Array{
            var _local2:Array = new Array(Math.ceil((_arg1.length / 4)));
            var _local3:Number = 0;
            while (_local3 < _local2.length) {
                _local2[_local3] = (((_arg1[(_local3 * 4)] + (_arg1[((_local3 * 4) + 1)] << 8)) + (_arg1[((_local3 * 4) + 2)] << 16)) + (_arg1[((_local3 * 4) + 3)] << 24));
                _local3++;
            };
            return (_local2);
        }
        private static function longsToChars(_arg1:Array):Array{
            var _local2:Array = new Array();
            var _local3:Number = 0;
            while (_local3 < _arg1.length) {
                _local2.push((_arg1[_local3] & 0xFF), ((_arg1[_local3] >>> 8) & 0xFF), ((_arg1[_local3] >>> 16) & 0xFF), ((_arg1[_local3] >>> 24) & 0xFF));
                _local3++;
            };
            return (_local2);
        }
        private static function longToChars(_arg1:Number):Array{
            var _local2:Array = new Array();
            _local2.push((_arg1 & 0xFF), ((_arg1 >>> 8) & 0xFF), ((_arg1 >>> 16) & 0xFF), ((_arg1 >>> 24) & 0xFF));
            return (_local2);
        }
        private static function charsToHex(_arg1:Array):String{
            var _local2:String = new String("");
            var _local3:Array = new Array("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f");
            var _local4:Number = 0;
            while (_local4 < _arg1.length) {
                _local2 = (_local2 + (_local3[(_arg1[_local4] >> 4)] + _local3[(_arg1[_local4] & 15)]));
                _local4++;
            };
            return (_local2);
        }
        private static function hexToChars(_arg1:String):Array{
            var _local2:Array = new Array();
            var _local3:Number = ((_arg1.substr(0, 2))=="0x") ? 2 : 0;
            while (_local3 < _arg1.length) {
                _local2.push(parseInt(_arg1.substr(_local3, 2), 16));
                _local3 = (_local3 + 2);
            };
            return (_local2);
        }
        private static function charsToStr(_arg1:Array):String{
            var _local2:String = new String("");
            var _local3:Number = 0;
            while (_local3 < _arg1.length) {
                _local2 = (_local2 + String.fromCharCode(_arg1[_local3]));
                _local3++;
            };
            return (_local2);
        }
        private static function strToChars(_arg1:String):Array{
            var _local2:Array = new Array();
            var _local3:Number = 0;
            while (_local3 < _arg1.length) {
                _local2.push(_arg1.charCodeAt(_local3));
                _local3++;
            };
            return (_local2);
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import com.greensock.*;
    import flash.net.*;
    import com.greensock.easing.*;
    import flash.media.*;
    import flash.utils.*;

    public class Advert extends MovieClip {

        private var advertShow:Timer;
        private var advertHide:Timer;
        private var loader:Loader;
        private var advert_mode:String;
        private var advert_url:String;
        private var advert_name:String;
        private var advert_visible:String;
        private var isTimerTick:Boolean = false;
        private var core:AdvertPlayerCore;
        private var hint_ad_url:TextField;
        private var hint_ad_text:TextField;
        private var hint_ad_close:SimpleButton;
        private var adv_pic:MovieClip;
        private var hint_ad_bg:MovieClip;
        private var mask_mc:Shape;

        public function Advert():void{
            this.initAdvertUI();
        }
        public function initAdvertUI():void{
            this.core = new AdvertPlayerCore();
            addChild(this.core);
            this.core.visible = false;
            this.hint_ad_url = this.core.hint_ad_url;
            this.hint_ad_text = this.core.hint_ad_text;
            this.hint_ad_close = this.core.hint_ad_close;
            this.hint_ad_bg = this.core.hint_ad_bg;
            this.adv_pic = this.core.adv_pic;
        }
        public function sortAdvertUI(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6, _arg7, _arg8, _arg9):void{
            this.hint_ad_url.mouseEnabled = false;
            this.hint_ad_text.mouseEnabled = false;
            this.hint_ad_bg.buttonMode = true;
            this.adv_pic.buttonMode = true;
            this.advert_mode = _arg4;
            this.advert_url = _arg2;
            this.advert_name = _arg8;
            this.advert_visible = _arg9;
            this.hint_ad_url.htmlText = _arg6;
            this.hint_ad_text.htmlText = _arg7;
            if (_arg8 == "1"){
                this.core.y = (stage.stageHeight + 15);
            } else {
                if (_arg8 == "2"){
                    this.core.y = -100;
                };
            };
            if (_arg1 == ""){
                this.adv_pic.visible = false;
                this.hint_ad_url.visible = true;
                this.hint_ad_text.visible = true;
            } else {
                this.loadThumb(_arg1);
                this.adv_pic.visible = true;
                this.hint_ad_url.visible = false;
                this.hint_ad_text.visible = false;
            };
            this.advertShow = new Timer(1000, _arg3);
            this.advertHide = new Timer(1000, _arg5);
            this.advertShow.addEventListener(TimerEvent.TIMER, this.advertShowOnTick);
            this.advertShow.addEventListener(TimerEvent.TIMER_COMPLETE, this.advertShowOnTimerComplete);
            this.advertHide.addEventListener(TimerEvent.TIMER, this.advertHideOnTick);
            this.advertHide.addEventListener(TimerEvent.TIMER_COMPLETE, this.advertHideOnTimerComplete);
            this.hint_ad_close.addEventListener(MouseEvent.CLICK, this.closeAdvert);
            this.hint_ad_bg.addEventListener(MouseEvent.CLICK, this.clickAdvert);
            this.adv_pic.addEventListener(MouseEvent.CLICK, this.clickAdvert);
            this.core.visible = true;
        }
        private function loadThumb(_arg1:String):void{
            if (this.loader){
                this.loader.unload();
            };
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadThumb);
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressThumb);
            this.loader.load(new URLRequest(_arg1));
        }
        private function progressThumb(_arg1:ProgressEvent):void{
        }
        private function onLoadThumb(_arg1:Event):void{
            var _local2:Number = (this.loader.height / this.loader.width);
            this.loader.width = 486;
            this.loader.height = (486 * _local2);
            this.adv_pic.addChild(this.loader);
        }
        private function clickAdvert(_arg1:MouseEvent):void{
            this.requestURL(this.advert_url);
        }
        private function requestURL(_arg1):void{
            var _local2:URLRequest = new URLRequest(_arg1);
            try {
                navigateToURL(_local2, "_blank");
            } catch(e) {
            };
        }
        public function startTimerShow():void{
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "2":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "3":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
            };
        }
        public function stopTimerShow():void{
            this.advertShow.reset();
            this.advertShow.stop();
            this.advertHide.reset();
            this.advertHide.stop();
            if (this.advert_name == "1"){
                this.core.y = (stage.stageHeight + 15);
            } else {
                if (this.advert_name == "2"){
                    this.core.y = -100;
                };
            };
            this.isTimerTick = false;
        }
        public function hideAdvert():void{
            if (this.advert_name == "1"){
                this.core.y = (stage.stageHeight + 15);
            } else {
                if (this.advert_name == "2"){
                    this.core.y = -100;
                };
            };
            this.isTimerTick = false;
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "2":
                    this.advertShow.reset();
                    this.advertShow.start();
                    break;
                case "3":
                    break;
            };
        }
        private function closeAdvert(_arg1:MouseEvent):void{
            switch (this.advert_mode){
                case "0":
                    break;
                case "1":
                    this.advertHide.stop();
                    this.hideAdvert();
                    break;
                case "2":
                    this.advertHide.stop();
                    if (this.advert_name == "1"){
                        this.core.y = (stage.stageHeight + 15);
                    } else {
                        if (this.advert_name == "2"){
                            this.core.y = -100;
                        };
                    };
                    this.isTimerTick = false;
                    break;
                case "3":
                    this.advertHide.stop();
                    this.hideAdvert();
                    break;
            };
        }
        private function advertShowOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function advertShowOnTimerComplete(_arg1:TimerEvent):void{
            if (this.advert_visible == "1"){
                if (this.advert_name == "1"){
                    this.core.y = (stage.stageHeight - 120);
                } else {
                    if (this.advert_name == "2"){
                        this.core.y = 0;
                    };
                };
                this.advertHide.reset();
                this.advertHide.start();
                this.isTimerTick = true;
            };
        }
        private function advertHideOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function advertHideOnTimerComplete(_arg1:TimerEvent):void{
            this.hideAdvert();
        }
        private function createMask(_arg1):void{
            this.mask_mc = new Shape();
            addChild(this.mask_mc);
            this.mask_mc.graphics.beginFill(0xFFFFFF, 1);
            this.mask_mc.graphics.lineStyle(0, 0, 0);
            this.mask_mc.graphics.moveTo(0, 0);
            this.mask_mc.graphics.lineTo(stage.stageWidth, 0);
            this.mask_mc.graphics.lineTo(stage.stageWidth, (stage.stageHeight - 33));
            this.mask_mc.graphics.lineTo(0, (stage.stageHeight - 33));
            this.mask_mc.graphics.lineTo(0, 0);
            this.mask_mc.graphics.endFill();
            _arg1.mask = this.mask_mc;
        }
        public function resizeAdvert():void{
            if (this.isTimerTick){
                if (this.advert_name == "1"){
                    this.core.y = (stage.stageHeight - 120);
                } else {
                    if (this.advert_name == "2"){
                        this.core.y = 0;
                    };
                };
            } else {
                if (this.advert_name == "1"){
                    this.core.y = (stage.stageHeight + 15);
                } else {
                    if (this.advert_name == "2"){
                        this.core.y = -100;
                    };
                };
            };
            this.core.x = ((stage.stageWidth / 2) - (this.core.width / 2));
        }

    }
}//package classes 
﻿package classes {
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import com.greensock.*;
    import flash.geom.*;
    import fl.transitions.*;
    import flash.net.*;
    import com.greensock.easing.*;
    import fl.transitions.easing.*;
    import flash.media.*;
    import flash.utils.*;
    import flash.system.*;
    import flash.ui.*;

    public class TvForsitePlayer extends MovieClip {

        private const DEFAULT_VOLUME:Number = 0.5;
        private const STEP_SCREENCAST:Number = 30;
        private const ORIGINAL_WIDTH:Number = 640;
        private const TIMELINE_WIDTH:Number = 0;
        private const scriptURL:String = "http://clients.cdnet.tv/flashplayer/fileinstruction.php";
        private const scriptAdvertURL:String = "http://clients.cdnet.tv/flashplayer/fileinstruction2.php";

        private var ng:NetGroup;
        private var connection:NetConnection;
        private var stream:NetStream;
        private var infoObject:Object;
        public var userid:String;
        public var videoid:String;
        public var videotype:String;
        public var sessid:String;
        private var originalSize:Point;
        private var timerSeek:Timer;
        private var timerDisplay:Timer;
        private var timerPanel:Timer;
        private var timerVolume:Timer;
        private var timerQuality:Timer;
        public var saveVolume:SaveVolume;
        private var XML:ReadXML;
        public var XMLVAST:ReadVASTXML;
        private var XMLADVERT:ReadAdvertXML;
        private var advert1:Advert;
        private var advert2:Advert;
        private var advert3:Advert2;
        private var advert4:Advert2;
        private var seekPoints:Array;
        private var keyframes:Array;
        private var videoPositions:Array;
        public var row_pic:Array;
        public var row_url:Array;
        public var row_title:Array;
        public var row_text:Array;
        public var syte_pic:Array;
        public var syte_url:Array;
        public var CONSOLE:Boolean = true;
        private var onTheRun:Boolean = false;
        private var isSquareScrub:Boolean = false;
        private var isVolumeScrub:Boolean = false;
        private var isHDClick:Boolean = false;
        public var isOpenPanel:Boolean = true;
        public var isTimer:Boolean = false;
        public var isHD:Boolean = false;
        public var preroll:Boolean = true;
        public var isStopAdvert:Boolean = false;
        public var isP2Ptext:Boolean = false;
        public var cl:Boolean = false;
        private var intervalHandler:uint;
        private var intervalPosition:uint;
        public var xml_autostart:String;
        public var xml_buffertime:String;
        public var xml_type_sd:String;
        public var xml_type_hd:String;
        public var xml_group_sd:String;
        public var xml_group_hd:String;
        public var xml_thumb:String;
        public var xml_filesd:String;
        public var xml_filehd:String;
        public var xml_link:String;
        public var xml_name:String;
        public var xml_ptext:String;
        public var xml_stream_sd_height:String;
        public var xml_stream_hd_height:String;
        public var xml_stream_sd_width:String;
        public var xml_stream_hd_width:String;
        public var xml_file_screencast:String;
        public var xml_num_screencast:String;
        public var xml_file_screencast_size:String;
        public var xml_thumb_url:String;
        public var xml_hide_panel:String;
        public var xml_stream_sd:String;
        public var xml_stream_hd:String;
        public var xml_chanel_sd:String;
        public var xml_chanel_hd:String;
        public var xml_blog:String;
        public var xml_code:String;
        public var xml_logo:String;
        public var xml_logo_url:String;
        public var xml_logo_position:String;
        public var xml_cl_setting:String;
        public var xml_cl_url:String;
        public var file:String;
        public var stream_width:String;
        public var stream_height:String;
        public var streams:String;
        public var group:String;
        public var type:String;
        public var sharedSecret = "Rd#n@k72JDh";
        public var player_preroll:String;
        public var player_preroll_file:String;
        public var player_preroll_url:String;
        private var i:int = 0;
        private var timeTick:int = 0;
        public var textColor:uint = 0xFFFFFF;
        public var selectionColor:uint = 0xFFFFFF;
        public var selectedColor:uint = 0;
        public var advert_top_pic:String;
        public var advert_top_url:String;
        public var advert_top_show:String;
        public var advert_top_mode:String;
        public var advert_top_hide:String;
        public var advert_top_title:String;
        public var advert_top_text:String;
        public var advert_bottom_pic:String;
        public var advert_bottom_url:String;
        public var advert_bottom_show:String;
        public var advert_bottom_mode:String;
        public var advert_bottom_hide:String;
        public var advert_bottom_title:String;
        public var advert_bottom_text:String;
        public var advert_left_pic:String;
        public var advert_left_url:String;
        public var advert_left_show:String;
        public var advert_left_mode:String;
        public var advert_left_hide:String;
        public var advert_left_title:String;
        public var advert_left_text:String;
        public var advert_right_pic:String;
        public var advert_right_url:String;
        public var advert_right_show:String;
        public var advert_right_mode:String;
        public var advert_right_hide:String;
        public var advert_right_title:String;
        public var advert_right_text:String;
        public var player_preroll_vastfile_url:String;
        public var player_preroll_vastfile_width:String;
        public var player_preroll_vastfile_hight:String;
        public var player_preroll_vastfile:String;
        public var player_urlvideopulse:String;
        public var tween_x:Tween;
        public var label_txt:TextField;
        private var tw:Number;
        private var th:Number;
        private var twidth:Number;
        private var theight:Number;
        private var stagewidth:Number;
        private var stageheight:Number;
        private var vw:Number;
        private var vh:Number;
        private var saveSound:Number;
        public var curNum:Number = 0;
        private var videoDuration:Number;
        private var currentX:Number = 0;
        private var move_scrubx:Number;
        public var sound_scrub_pos = 0;
        private var keyframe;
        private var back_off_mouseX:Number;
        private var loadXCoeff:Number;
        private var loadWidthCoeff:Number;
        private var squareXCoeff:Number;
        public var second:Number;
        private var cur_screencast:Number = 1;
        public var curNumAdvert:Number = 0;
        public var prerollNum:Number = 0;
        private var loader:Loader;
        private var loaderLogo:Loader;
        private var newColor:ColorTransform;
        private var core:TvForsitePlayerCore;
        private var video:Video;
        private var thumb:MovieClip;
        private var back:MovieClip;
        private var panel:MovieClip;
        private var top_panel:MovieClip;
        private var big_time_btn:MovieClip;
        private var big_pause_btn:MovieClip;
        private var big_play_btn:MovieClip;
        private var big_reload_btn:MovieClip;
        private var click_line:MovieClip;
        private var loaded_line:MovieClip;
        private var played_line:MovieClip;
        private var square_btn:MovieClip;
        private var fullscreen_btn:MovieClip;
        private var normal_btn:MovieClip;
        private var back_off:MovieClip;
        private var play_btn:MovieClip;
        private var pause_btn:MovieClip;
        private var time_all:TextField;
        private var quality_hq_btn:MovieClip;
        private var quality_lq_btn:MovieClip;
        private var volume_h:MovieClip;
        private var quality:MovieClip;
        private var quality_choice:MovieClip;
        private var mute:MovieClip;
        private var nomute:MovieClip;
        private var square_volume:MovieClip;
        private var back_panel:MovieClip;
        private var top_back_panel:MovieClip;
        private var advert_close:MovieClip;
        private var sound_line_fon:MovieClip;
        private var square_sound:MovieClip;
        private var quality_back:MovieClip;
        private var sd:MovieClip;
        private var hd:MovieClip;
        private var screencast:MovieClip;
        private var popup:MovieClip;
        private var related:MovieClip;
        private var back_related:MovieClip;
        private var progressBar:MovieClip;
        private var vblog:MovieClip;
        private var code_txt:TextField;
        private var blog_txt:TextField;
        private var url_txt:TextField;
        private var code_btn:MovieClip;
        private var blog_btn:MovieClip;
        private var url_btn:MovieClip;
        private var line_syte:MovieClip;
        private var vblog_btn:MovieClip;
        private var logo:MovieClip;
        private var p2ptext:TextField;
        private var loading:MovieClip;
        private var pixel_sd:MovieClip;
        private var pixel_hd:MovieClip;

        public function TvForsitePlayer():void{
            this.row_pic = new Array();
            this.row_url = new Array();
            this.row_title = new Array();
            this.row_text = new Array();
            this.syte_pic = new Array();
            this.syte_url = new Array();
            this.newColor = new ColorTransform();
            super();
            this.initUI();
        }
        private function initUI():void{
            this.core = new TvForsitePlayerCore();
            addChild(this.core);
            this.core.visible = false;
            this.related = new Related();
            addChild(this.related);
            this.popup = new m_popup();
            addChild(this.popup);
            this.screencast = new m_screencast();
            addChild(this.screencast);
            this.popup.visible = false;
            this.screencast.visible = false;
            this.advert1 = new Advert();
            addChild(this.advert1);
            this.advert2 = new Advert();
            addChild(this.advert2);
            this.advert3 = new Advert2();
            addChild(this.advert3);
            this.advert4 = new Advert2();
            addChild(this.advert4);
            this.createLabelTexField();
            this.selectedText();
            this.thumb = this.core.thumb;
            this.back = this.core.back;
            this.panel = this.core.panel;
            this.back_panel = this.core.panel.back_panel;
            this.top_panel = this.core.top_panel;
            this.top_back_panel = this.core.top_panel.back_panel;
            this.advert_close = this.core.top_panel.advert_close;
            this.video = this.core.vidDisplay;
            this.big_time_btn = this.core.big_time_btn;
            this.big_pause_btn = this.core.big_pause_btn;
            this.big_play_btn = this.core.big_play_btn;
            this.big_reload_btn = this.core.big_reload_btn;
            this.progressBar = this.core.panel.progressBar;
            this.click_line = this.core.panel.progressBar.click_line;
            this.loaded_line = this.core.panel.progressBar.loading;
            this.played_line = this.core.panel.progressBar.playing;
            this.back_off = this.core.panel.progressBar.bg;
            this.square_btn = this.core.panel.progressBar.point;
            this.fullscreen_btn = this.core.panel.fullscreen_btn;
            this.normal_btn = this.core.panel.normal_btn;
            this.play_btn = this.core.panel.play_btn;
            this.pause_btn = this.core.panel.pause_btn;
            this.time_all = this.core.panel.time;
            this.quality_hq_btn = this.core.panel.quality_hq_btn;
            this.quality_lq_btn = this.core.panel.quality_lq_btn;
            this.quality = this.core.panel.quality;
            this.quality_choice = this.core.panel.quality_choice;
            this.quality_back = this.core.panel.quality_choice.back;
            this.sd = this.core.panel.quality_choice.sd;
            this.pixel_sd = this.core.panel.quality_choice.sd.pixel_sd;
            this.hd = this.core.panel.quality_choice.hd;
            this.pixel_hd = this.core.panel.quality_choice.hd.pixel_hd;
            this.volume_h = this.core.panel.volume_h;
            this.sound_line_fon = this.core.panel.volume_h.bg;
            this.square_sound = this.core.panel.volume_h.square;
            this.mute = this.core.panel.mute;
            this.nomute = this.core.panel.nomute;
            this.square_volume = this.core.panel.volume_h.square;
            this.back_related = this.core.back_related;
            this.vblog = this.core.vblog;
            this.code_txt = this.core.vblog.code_txt;
            this.blog_txt = this.core.vblog.blog_txt;
            this.url_txt = this.core.vblog.url_txt;
            this.code_btn = this.core.vblog.code_btn;
            this.blog_btn = this.core.vblog.blog_btn;
            this.url_btn = this.core.vblog.url_btn;
            this.line_syte = this.core.vblog.line_syte;
            this.vblog_btn = this.core.panel.vblog_btn;
            this.logo = this.core.logo;
            this.p2ptext = this.core.ptext;
            this.loading = this.core.preloader;
        }
        public function sortUI(_arg1:String, _arg2:String, _arg3:String, _arg4:String):void{
            this.userid = _arg1;
            this.videoid = _arg2;
            this.videotype = _arg3;
            this.sessid = _arg4;
            this.XML = new ReadXML(this);
            this.XML.configXML(((((((((this.scriptURL + "?userid=") + _arg1) + "&videoid=") + _arg2) + "&type=") + _arg3) + "&sessid=") + _arg4));
            this.XMLADVERT = new ReadAdvertXML(this);
            this.XMLVAST = new ReadVASTXML(this);
        }
        public function playerUIAdvert():void{
            switch (this.videotype){
                case "file":
                    if (this.player_preroll == "1"){
                        this.preroll = true;
                    } else {
                        if (this.player_preroll == "2"){
                            this.preroll = true;
                        } else {
                            this.preroll = false;
                            this.prerollNum = 1;
                        };
                    };
                    this.createConnectFile();
                    break;
                case "stream":
                    if (this.player_preroll == "1"){
                        this.preroll = true;
                        this.createConnectFile();
                    } else {
                        if (this.player_preroll == "2"){
                            this.preroll = true;
                            this.player_preroll_file = this.player_preroll_vastfile;
                            trace(this.player_preroll_vastfile);
                            this.player_preroll_url = this.player_preroll_vastfile_url;
                            this.createConnectFile();
                        } else {
                            this.preroll = false;
                            this.prerollNum = 1;
                            if (this.type == "1"){
                                this.createConnectP2P();
                            } else {
                                this.createConnect();
                            };
                        };
                    };
                    break;
            };
        }
        public function openAdvertWindow():void{
            switch (this.xml_cl_setting){
                case "0":
                    break;
                case "1":
                    if (!this.cl){
                        this.requestURL(this.xml_cl_url);
                    };
                    this.cl = true;
                    break;
                case "2":
                    if (!this.cl){
                        this.requestURL(this.xml_cl_url);
                    };
                    this.cl = true;
                    break;
            };
        }
        public function advertBlock():void{
            if (this.advert_top_mode != null){
                this.advert1.sortAdvertUI(this.advert_top_pic, this.advert_top_url, this.advert_top_show, this.advert_top_mode, this.advert_top_hide, this.advert_top_title, this.advert_top_text, "2", "1");
                this.advert1.startTimerShow();
                if ((((this.advert_bottom_mode == null)) && (!((this.curNumAdvert == 0))))){
                    this.advert2.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert2.startTimerShow();
                    this.advert3.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert3.startTimerShow();
                    this.advert4.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert4.startTimerShow();
                };
            };
            if (this.advert_bottom_mode != null){
                this.advert2.sortAdvertUI(this.advert_bottom_pic, this.advert_bottom_url, this.advert_bottom_show, this.advert_bottom_mode, this.advert_bottom_hide, this.advert_bottom_title, this.advert_bottom_text, "1", "1");
                this.advert2.startTimerShow();
                if ((((this.advert_top_mode == null)) && (!((this.curNumAdvert == 0))))){
                    this.advert1.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert1.startTimerShow();
                    this.advert3.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert3.startTimerShow();
                    this.advert4.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert4.startTimerShow();
                };
            };
            if (this.advert_left_mode != null){
                this.advert3.sortAdvertUI(this.advert_left_pic, this.advert_left_url, this.advert_left_show, this.advert_left_mode, this.advert_left_hide, this.advert_left_title, this.advert_left_text, "1", "1");
                this.advert3.startTimerShow();
                if ((((this.advert_right_mode == null)) && (!((this.curNumAdvert == 0))))){
                    this.advert1.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert1.startTimerShow();
                    this.advert2.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert2.startTimerShow();
                    this.advert4.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert4.startTimerShow();
                };
            };
            if (this.advert_right_mode != null){
                this.advert4.sortAdvertUI(this.advert_right_pic, this.advert_right_url, this.advert_right_show, this.advert_right_mode, this.advert_right_hide, this.advert_right_title, this.advert_right_text, "2", "1");
                this.advert4.startTimerShow();
                if ((((this.advert_left_mode == null)) && (!((this.curNumAdvert == 0))))){
                    this.advert1.sortAdvertUI("", "", "0", "0", "0", "", "", "2", "0");
                    this.advert1.startTimerShow();
                    this.advert2.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert2.startTimerShow();
                    this.advert3.sortAdvertUI("", "", "0", "0", "0", "", "", "1", "0");
                    this.advert3.startTimerShow();
                };
            };
            this.resizePlayer();
        }
        public function playerUI():void{
            var _local4:*;
            if (this.row_pic.length > 0){
                this.related.sortRelatedUI(this.row_pic, this.row_url, this.row_title, this.row_text);
            };
            if (this.xml_logo != ""){
                this.loadLogo(this.xml_logo);
            };
            this.p2ptext.text = this.xml_ptext;
            this.p2ptext.visible = false;
            this.pixel_hd.visible = false;
            this.loading.visible = false;
            this.loading.buttonMode = false;
            this.loading.useHandCursor = false;
            this.loading.mouseChildren = false;
            this.label_txt.visible = false;
            this.big_pause_btn.visible = false;
            this.big_time_btn.visible = false;
            this.big_reload_btn.visible = false;
            this.pause_btn.visible = false;
            this.normal_btn.visible = false;
            this.loaded_line.width = 0;
            this.played_line.width = 0;
            this.click_line.width = 0;
            this.square_btn.x = ((this.square_btn.width / 2) - 3);
            this.volume_h.visible = false;
            this.quality_choice.visible = false;
            this.back_related.visible = false;
            this.advert_close.visible = false;
            this.vblog.visible = false;
            this.quality_hq_btn.visible = false;
            this.code_txt.htmlText = this.xml_code;
            this.blog_txt.htmlText = this.xml_blog;
            this.url_txt.htmlText = this.xml_link;
            this.top_panel.title.htmlText = this.xml_name;
            if (((!((this.xml_file_screencast == ""))) && (!((this.xml_num_screencast == ""))))){
                _local4 = 0;
                while (_local4 < Number(this.xml_num_screencast)) {
                    this.screencast.img[("img" + _local4)] = new m_screencast_img();
                    this.screencast.img[("img" + _local4)].num = _local4;
                    this.screencast.img[("img" + _local4)].x = 0;
                    this.screencast.img[("img" + _local4)].y = 0;
                    this.screencast.img[("img" + _local4)].visible = false;
                    this.screencast.img.addChild(this.screencast.img[("img" + _local4)]);
                    this.loadImages(((((this.xml_file_screencast + (_local4 + 1)) + "_") + this.xml_file_screencast_size) + ".png"), _local4);
                    _local4++;
                };
            };
            if (this.xml_thumb != ""){
                this.loadThumb(this.xml_thumb);
            };
            if (this.xml_thumb_url != ""){
                this.thumb.addEventListener(MouseEvent.CLICK, this.clickThumb);
            };
            if (this.xml_logo_url != ""){
                this.logo.addEventListener(MouseEvent.CLICK, this.clickLogo);
                this.logo.buttonMode = true;
            };
            var _local1:ContextMenu = new ContextMenu();
            _local1.hideBuiltInItems();
            var _local2:ContextMenuItem = new ContextMenuItem("посмотреть это видео на tvforsite.net");
            _local2.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, this.clickURL);
            _local1.customItems.push(_local2);
            var _local3:ContextMenuItem = new ContextMenuItem("player version 10.9.8 p2p");
            _local1.customItems.push(_local3);
            contextMenu = _local1;
            this.addEventListener(MouseEvent.MOUSE_UP, this.mouseUp);
            this.addEventListener(MouseEvent.MOUSE_MOVE, this.mouseMove);
            stage.addEventListener(KeyboardEvent.KEY_DOWN, this.keyPressed);
            stage.addEventListener(FullScreenEvent.FULL_SCREEN, this.fullScreenRedraw);
            stage.addEventListener(Event.RESIZE, this.resizeHandler);
            this.back.addEventListener(MouseEvent.CLICK, this.videoClick);
            this.big_play_btn.addEventListener(MouseEvent.CLICK, this.play_pause);
            this.big_play_btn.buttonMode = true;
            this.play_btn.addEventListener(MouseEvent.CLICK, this.play_pause);
            this.play_btn.buttonMode = true;
            this.pause_btn.addEventListener(MouseEvent.CLICK, this.play_pause);
            this.pause_btn.buttonMode = true;
            this.square_btn.addEventListener(MouseEvent.MOUSE_DOWN, this.squareDown);
            this.fullscreen_btn.addEventListener(MouseEvent.CLICK, this.fullScreen);
            this.fullscreen_btn.buttonMode = true;
            this.normal_btn.addEventListener(MouseEvent.CLICK, this.fullScreen);
            this.normal_btn.buttonMode = true;
            this.click_line.addEventListener(MouseEvent.CLICK, this.loadClick);
            this.click_line.addEventListener(MouseEvent.MOUSE_OVER, this.seeTime);
            this.click_line.addEventListener(MouseEvent.MOUSE_OUT, this.hideTime);
            this.click_line.buttonMode = true;
            this.back_off.addEventListener(MouseEvent.CLICK, this.backClick);
            this.back_off.addEventListener(MouseEvent.MOUSE_OVER, this.seeTime);
            this.back_off.addEventListener(MouseEvent.MOUSE_OUT, this.hideTime);
            this.mute.addEventListener(MouseEvent.CLICK, this.clickVolume);
            this.mute.buttonMode = true;
            this.advert_close.addEventListener(MouseEvent.CLICK, this.advertClose);
            this.advert_close.buttonMode = true;
            this.sound_line_fon.addEventListener(MouseEvent.MOUSE_DOWN, this.startChangeVolume);
            this.sound_line_fon.addEventListener(MouseEvent.MOUSE_UP, this.stopChangeVolume);
            this.sound_line_fon.addEventListener(MouseEvent.CLICK, this.clickChangeVolume);
            this.sound_line_fon.buttonMode = true;
            this.square_sound.mouseEnabled = false;
            this.timerSeek = new Timer(1000);
            this.timerVolume = new Timer(1000, 1);
            this.timerVolume.addEventListener(TimerEvent.TIMER, this.timerVolumeOnTick);
            this.timerVolume.addEventListener(TimerEvent.TIMER_COMPLETE, this.timerVolumeOnTimerComplete);
            this.timerQuality = new Timer(1000, 1);
            this.timerQuality.addEventListener(TimerEvent.TIMER, this.timerQualityOnTick);
            this.timerQuality.addEventListener(TimerEvent.TIMER_COMPLETE, this.timerQualityOnTimerComplete);
            this.timerPanel = new Timer(1000, Number(this.xml_hide_panel));
            this.timerPanel.addEventListener(TimerEvent.TIMER, this.onTickPanel);
            this.timerPanel.addEventListener(TimerEvent.TIMER_COMPLETE, this.onTimerPanelComplete);
            this.mute.addEventListener(MouseEvent.MOUSE_OVER, this.seeVolume);
            this.mute.addEventListener(MouseEvent.MOUSE_OUT, this.hideVolume);
            this.volume_h.addEventListener(MouseEvent.MOUSE_OVER, this.seeVolume);
            this.volume_h.addEventListener(MouseEvent.MOUSE_OUT, this.hideVolume);
            if (((this.xml_filehd) || (this.xml_stream_hd))){
                this.quality_hq_btn.addEventListener(MouseEvent.MOUSE_OVER, this.seeQuality);
                this.quality_hq_btn.addEventListener(MouseEvent.MOUSE_OUT, this.hideQuality);
                this.quality_hq_btn.buttonMode = true;
                this.quality_lq_btn.addEventListener(MouseEvent.MOUSE_OVER, this.seeQuality);
                this.quality_lq_btn.addEventListener(MouseEvent.MOUSE_OUT, this.hideQuality);
                this.quality_lq_btn.buttonMode = true;
                this.quality_choice.addEventListener(MouseEvent.MOUSE_OVER, this.seeQuality);
                this.quality_choice.addEventListener(MouseEvent.MOUSE_OUT, this.hideQuality);
            };
            this.big_reload_btn.addEventListener(MouseEvent.CLICK, this.replay);
            this.big_reload_btn.buttonMode = true;
            this.panel.addEventListener(MouseEvent.ROLL_OVER, this.timer_stop);
            this.panel.addEventListener(MouseEvent.ROLL_OUT, this.timer_start);
            this.code_btn.addEventListener(MouseEvent.CLICK, this.copyCode);
            this.code_btn.buttonMode = true;
            this.blog_btn.addEventListener(MouseEvent.CLICK, this.copyBlog);
            this.blog_btn.buttonMode = true;
            this.url_btn.addEventListener(MouseEvent.CLICK, this.copyUrl);
            this.url_btn.buttonMode = true;
            this.vblog_btn.addEventListener(MouseEvent.CLICK, this.vblogClick);
            this.vblog_btn.buttonMode = true;
            this.selectedTextBlog();
            this.createSite();
            switch (this.videotype){
                case "file":
                    this.file = this.xml_filesd;
                    this.hd.addEventListener(MouseEvent.CLICK, this.HD);
                    this.hd.buttonMode = true;
                    this.sd.addEventListener(MouseEvent.CLICK, this.HD);
                    this.sd.buttonMode = true;
                    break;
                case "stream":
                    this.progressBar.visible = false;
                    this.time_all.visible = false;
                    this.vblog_btn.visible = false;
                    this.panel.line_vblog.visible = false;
                    this.file = this.xml_chanel_sd;
                    this.streams = this.xml_stream_sd;
                    this.group = this.xml_group_sd;
                    this.type = this.xml_type_sd;
                    this.hd.addEventListener(MouseEvent.CLICK, this.StreamHD);
                    this.hd.buttonMode = true;
                    this.sd.addEventListener(MouseEvent.CLICK, this.StreamHD);
                    this.sd.buttonMode = true;
                    break;
            };
            this.saveVolume = new SaveVolume();
            if (!isNaN(this.saveVolume.getLevelVolume())){
                this.saveSound = this.saveVolume.getLevelVolume();
                if (this.saveSound < 0){
                    this.saveSound = 0;
                } else {
                    if (this.saveSound > 1){
                        this.saveSound = 1;
                    };
                };
            } else {
                this.saveSound = this.DEFAULT_VOLUME;
            };
            if (this.saveSound > 0){
                this.nomute.visible = true;
            } else {
                this.nomute.visible = false;
            };
            this.square_sound.y = (((1 - this.saveSound) * this.sound_line_fon.height) + 11);
            this.quality_back.y = 20;
            this.resizePlayer();
            this.loadWidthCoeff = (this.loaded_line.width / this.ORIGINAL_WIDTH);
            this.squareXCoeff = (this.square_btn.x / this.ORIGINAL_WIDTH);
            this.core.visible = true;
            if (this.xml_autostart == "true"){
                switch (this.videotype){
                    case "file":
                        this.XMLADVERT.configXML(((this.scriptAdvertURL + "?sessid=") + this.sessid));
                        this.curNumAdvert++;
                        break;
                    case "stream":
                        this.XMLADVERT.configXML(((this.scriptAdvertURL + "?sessid=") + this.sessid));
                        this.curNumAdvert++;
                        break;
                };
            };
            switch (this.xml_cl_setting){
                case "0":
                    break;
                case "1":
                    break;
                case "2":
                    this.openAdvertWindow();
                    break;
            };
        }
        private function videoClick(_arg1:MouseEvent):void{
            if (this.preroll){
                this.requestURL(this.player_preroll_url);
            };
        }
        private function advertClose(_arg1:MouseEvent):void{
            this.stopSound();
            this.preroll = false;
            this.onTheRun = false;
            this.originalSize = null;
            this.videoDuration = 0;
            this.prerollNum++;
            if (this.prerollNum < 2){
                switch (this.videotype){
                    case "file":
                        this.createConnectFile();
                        break;
                    case "stream":
                        if (this.type == "1"){
                            this.createConnectP2P();
                        } else {
                            this.createConnect();
                        };
                        break;
                };
            };
        }
        private function vblogClick(_arg1:MouseEvent):void{
            if (this.vblog.visible == false){
                this.vblog.visible = true;
            } else {
                this.vblog.visible = false;
            };
        }
        private function createSite():void{
            var temp:* = undefined;
            this.i = 0;
            while (this.i < this.syte_url.length) {
                this.vblog.line_syte[("line_syte" + this.i)] = new m_site();
                this.vblog.line_syte[("line_syte" + this.i)].link = this.syte_url[this.i];
                this.vblog.line_syte[("line_syte" + this.i)].num = this.i;
                this.vblog.line_syte[("line_syte" + this.i)].x = (30 * this.i);
                this.vblog.line_syte[("line_syte" + this.i)].y = 0;
                if (((this.syte_url[this.i]) && (this.syte_pic[this.i]))){
                    var clickSite:* = function (_arg1:MouseEvent):void{
                        requestURL(_arg1.target.link);
                    };
                    this.loadImagesSite(this.syte_pic[this.i], this.i);
                    this.vblog.line_syte[("line_syte" + this.i)].buttonMode = true;
                    this.vblog.line_syte[("line_syte" + this.i)].addEventListener(MouseEvent.CLICK, clickSite);
                };
                this.vblog.line_syte.addChild(this.vblog.line_syte[("line_syte" + this.i)]);
                temp = (this.vblog.line_syte[("line_syte" + this.i)].x + 24);
                this.i++;
            };
            this.vblog.line_syte.x = ((this.vblog.width - temp) - 24);
        }
        private function loadImagesSite(_arg1, _arg2):void{
            var picLoader:* = null;
            var onLoadProgress:* = null;
            var onLoadComplete:* = null;
            var url:* = _arg1;
            var i:* = _arg2;
            onLoadProgress = function (_arg1:ProgressEvent):void{
            };
            onLoadComplete = function (_arg1:Event):void{
                picLoader.content.width = 24;
                picLoader.content.height = 24;
                vblog.line_syte[("line_syte" + i)].addChild(picLoader.content);
            };
            var picURL:* = new URLRequest(url);
            picLoader = new Loader();
            picLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
            picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            picLoader.load(picURL);
        }
        private function loadLogo(_arg1:String):void{
            this.loaderLogo = new Loader();
            this.loaderLogo.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadLogo);
            this.loaderLogo.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressLogo);
            this.loaderLogo.load(new URLRequest(_arg1));
        }
        private function progressLogo(_arg1:ProgressEvent):void{
        }
        private function onLoadLogo(_arg1:Event):void{
            this.logo.addChild(this.loaderLogo);
            switch (this.xml_logo_position){
                case "left-up":
                    this.logo.x = 0;
                    this.logo.y = 0;
                    break;
                case "left-down":
                    this.logo.x = 0;
                    this.logo.y = (stage.stageHeight - this.logo.height);
                    break;
                case "right-up":
                    this.logo.x = (stage.stageWidth - this.logo.width);
                    this.logo.y = 0;
                    break;
                case "right-down":
                    this.logo.x = (stage.stageWidth - this.logo.width);
                    this.logo.y = (stage.stageHeight - this.logo.height);
                    break;
            };
        }
        private function copyCode(_arg1:MouseEvent):void{
            System.setClipboard(this.xml_code);
        }
        private function copyUrl(_arg1:MouseEvent):void{
            System.setClipboard(this.xml_link);
        }
        private function copyBlog(_arg1:MouseEvent):void{
            System.setClipboard(this.xml_blog);
        }
        private function createConnect(){
            this.label_txt.htmlText = "";
            this.connection = new NetConnection();
            this.connection.objectEncoding = ObjectEncoding.AMF3;
            this.connection.addEventListener(NetStatusEvent.NET_STATUS, this.netStatus);
            this.connection.connect(this.streams);
        }
        private function createConnectP2P(){
            this.label_txt.htmlText = "";
            this.connection = new NetConnection();
            this.connection.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandlerP2P);
            this.connection.connect(this.streams);
            if (!this.isP2Ptext){
                this.p2ptext.visible = true;
            };
        }
        private function netStatus(_arg1:NetStatusEvent):void{
            var secureResult:* = null;
            var event:* = _arg1;
            if (event.info.code == "NetConnection.Connect.Rejected"){
            };
            if (event.info.code == "NetConnection.Connect.Success"){
                if (event.info.secureToken != undefined){
                    secureResult = new Object();
                    secureResult.onResult = function (_arg1:Boolean){
                    };
                    this.connection.call("secureTokenResponse", new Responder(secureResult.onResult), TEA.decrypt(event.info.secureToken, this.sharedSecret));
                    this.createStream();
                };
            };
        }
        private function formNetGroup():void{
            this.ng = new NetGroup(this.connection, this.group);
            this.ng.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
        }
        private function createConnectFile(){
            this.connection = new NetConnection();
            this.connection.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this.connection.connect(null);
            this.createStream();
        }
        private function createStreamP2P():void{
            this.stream = new NetStream(this.connection, this.group);
            this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandlerP2P);
            this.stream.addEventListener(IOErrorEvent.IO_ERROR, this.streamIOError);
            this.stream.addEventListener(StatusEvent.STATUS, this.streamStatus);
            this.stream.bufferTime = Number(this.xml_buffertime);
            this.stream.client = this;
            this.video.attachNetStream(this.stream);
            this.video.smoothing = true;
            if (this.preroll){
                this.file = this.player_preroll_file;
                this.advert_close.visible = true;
                this.time_all.visible = true;
                this.pause_btn.mouseEnabled = false;
                this.quality_lq_btn.mouseEnabled = false;
                this.vblog_btn.mouseEnabled = false;
            } else {
                if (this.isHD == true){
                    this.file = this.xml_chanel_hd;
                    this.streams = this.xml_stream_hd;
                    this.stream_width = this.xml_stream_hd_width;
                    this.stream_height = this.xml_stream_hd_height;
                } else {
                    this.file = this.xml_chanel_sd;
                    this.streams = this.xml_stream_sd;
                    this.stream_width = this.xml_stream_sd_width;
                    this.stream_height = this.xml_stream_sd_height;
                };
                trace(("----" + this.streams));
                this.advert_close.visible = false;
                this.time_all.visible = false;
                this.pause_btn.mouseEnabled = true;
                this.quality_lq_btn.mouseEnabled = true;
                this.vblog_btn.mouseEnabled = false;
                this.advertBlock();
            };
            this.playSound();
            this.onMetaDatas();
        }
        private function createStream():void{
            this.stream = new NetStream(this.connection);
            this.stream.addEventListener(NetStatusEvent.NET_STATUS, this.netStatusHandler);
            this.stream.addEventListener(IOErrorEvent.IO_ERROR, this.streamIOError);
            this.stream.addEventListener(StatusEvent.STATUS, this.streamStatus);
            this.stream.bufferTime = Number(this.xml_buffertime);
            this.stream.client = this;
            this.video.attachNetStream(this.stream);
            this.video.smoothing = true;
            switch (this.videotype){
                case "file":
                    if (this.preroll){
                        this.file = this.player_preroll_file;
                        this.advert_close.visible = true;
                        this.progressBar.visible = false;
                        this.pause_btn.mouseEnabled = false;
                        this.quality_lq_btn.mouseEnabled = false;
                        this.vblog_btn.mouseEnabled = false;
                    } else {
                        if (this.isHD == true){
                            this.file = this.xml_filehd;
                        } else {
                            this.file = this.xml_filesd;
                        };
                        this.advert_close.visible = false;
                        this.progressBar.visible = true;
                        this.pause_btn.mouseEnabled = true;
                        this.quality_lq_btn.mouseEnabled = true;
                        this.vblog_btn.mouseEnabled = true;
                        this.advertBlock();
                    };
                    this.playSound();
                    break;
                case "stream":
                    if (this.preroll){
                        this.file = this.player_preroll_file;
                        this.advert_close.visible = true;
                        this.time_all.visible = true;
                        this.pause_btn.mouseEnabled = false;
                        this.quality_lq_btn.mouseEnabled = false;
                        this.vblog_btn.mouseEnabled = false;
                    } else {
                        if (this.isHD == true){
                            this.file = this.xml_chanel_hd;
                            this.streams = this.xml_stream_hd;
                            this.group = this.xml_group_hd;
                            this.type = this.xml_type_hd;
                        } else {
                            this.file = this.xml_chanel_sd;
                            this.streams = this.xml_stream_sd;
                            this.group = this.xml_group_sd;
                            this.type = this.xml_type_sd;
                        };
                        this.advert_close.visible = false;
                        this.time_all.visible = false;
                        this.pause_btn.mouseEnabled = true;
                        this.quality_lq_btn.mouseEnabled = true;
                        this.vblog_btn.mouseEnabled = false;
                        this.advertBlock();
                    };
                    this.playSound();
                    break;
            };
        }
        private function getNearestSeekpoint(_arg1:Number, _arg2:Array):uint{
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            while (_local5 != _arg2.length) {
                if (_arg2[_local5]["time"] < _arg1){
                    _local3 = _local5;
                } else {
                    _local4 = _local5;
                    break;
                };
                _local5++;
            };
            if ((_arg1 - _arg2[_local3]["time"]) < (_arg2[_local4]["time"] - _arg1)){
                return (_local3);
            };
            return (_local4);
        }
        private function getNearestKeyframe(_arg1:Number, _arg2:Array):uint{
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            while (_local5 != _arg2.length) {
                if (_arg2[_local5] < _arg1){
                    _local3 = _local5;
                } else {
                    _local4 = _local5;
                    break;
                };
                _local5++;
            };
            if ((_arg1 - _arg2[_local3]) < (_arg2[_local4] - _arg1)){
                return (_local3);
            };
            return (_local4);
        }
        private function onTickPanel(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function onTimerPanelComplete(_arg1:TimerEvent):void{
            if (stage.displayState == StageDisplayState.NORMAL){
                if (((!(this.isSquareScrub)) && (!(this.isOpenPanel)))){
                    this.gotoDown();
                };
            } else {
                if (((!(this.isSquareScrub)) && (!(this.isOpenPanel)))){
                    this.gotoDown();
                };
            };
        }
        private function gotoDown():void{
            TweenMax.to(this.top_panel, 1, {
                y:-144,
                ease:Cubic.easeOut
            });
            TweenMax.to(this.panel, 1, {
                y:(stage.stageHeight + 28),
                ease:Cubic.easeOut
            });
        }
        private function gotoUp():void{
            TweenMax.to(this.top_panel, 0.5, {
                y:0,
                ease:Cubic.easeOut
            });
            TweenMax.to(this.panel, 0.5, {
                y:(stage.stageHeight - 28),
                ease:Cubic.easeOut
            });
        }
        private function timer_start(_arg1:MouseEvent):void{
            if (this.onTheRun){
                if (this.pause_btn.visible){
                    if (stage.displayState == StageDisplayState.NORMAL){
                        if (!this.isSquareScrub){
                            this.timerPanel.reset();
                            this.timerPanel.start();
                        };
                    } else {
                        if (!this.isSquareScrub){
                            this.timerPanel.reset();
                            this.timerPanel.start();
                        };
                    };
                    this.isTimer = true;
                };
                this.isOpenPanel = false;
            };
        }
        private function timer_stop(_arg1:MouseEvent):void{
            if (this.onTheRun){
                this.timerPanel.reset();
                this.timerPanel.stop();
                this.isTimer = false;
                this.isOpenPanel = true;
            };
        }
        private function hideTime(_arg1:MouseEvent):void{
            this.hideTimes();
        }
        private function hideTimes():void{
            if (this.onTheRun){
                removeEventListener(Event.ENTER_FRAME, this.setPopup);
                this.popup.visible = false;
                this.screencast.visible = false;
            };
        }
        private function setPopup(_arg1:Event):void{
            if (this.mouseX < (this.popup.width / 2)){
                this.popup.x = 0;
            } else {
                if (this.mouseX > (stage.stageWidth - (this.popup.width / 2))){
                    this.popup.x = (stage.stageWidth - this.popup.width);
                } else {
                    this.popup.x = (this.mouseX - (this.popup.width / 2));
                };
            };
            if (this.mouseX < (this.screencast.width / 2)){
                this.screencast.x = 0;
            } else {
                if (this.mouseX > (stage.stageWidth - (this.screencast.width / 2))){
                    this.screencast.x = (stage.stageWidth - this.screencast.width);
                } else {
                    this.screencast.x = (this.mouseX - (this.screencast.width / 2));
                };
            };
            if (((!((this.xml_file_screencast == ""))) && (!((this.xml_num_screencast == ""))))){
                this.screencast.visible = true;
            };
            this.popup.visible = true;
            var _local2:Number = Math.round(((this.mouseX / this.back_off.width) * 1000));
            var _local3:Number = Math.round(((this.videoDuration * _local2) / 1000));
            this.popup.time.htmlText = (("<b>" + this.formatTime(_local3)) + "</b>");
            this.cur_screencast = Math.floor((_local3 / this.STEP_SCREENCAST));
            if (this.cur_screencast >= Number(this.xml_num_screencast)){
                this.cur_screencast = (Number(this.xml_num_screencast) - 1);
            };
            this.seeScreencast(this.cur_screencast);
        }
        private function seeScreencast(_arg1:Number):void{
            var _local2:* = 0;
            while (_local2 < Number(this.xml_num_screencast)) {
                if (_local2 == _arg1){
                    this.screencast.img[("img" + _local2)].visible = true;
                } else {
                    this.screencast.img[("img" + _local2)].visible = false;
                };
                _local2++;
            };
        }
        private function seeTime(_arg1:MouseEvent):void{
            this.seeTimes();
        }
        private function seeTimes():void{
            if (this.onTheRun){
                if (this.infoObject.keyframes){
                    if (this.click_line.width > 1){
                        addEventListener(Event.ENTER_FRAME, this.setPopup);
                    };
                } else {
                    if (this.infoObject.seekpoints){
                        if (this.click_line.width > 1){
                            addEventListener(Event.ENTER_FRAME, this.setPopup);
                        };
                    } else {
                        if (this.click_line.width > 1){
                            addEventListener(Event.ENTER_FRAME, this.setPopup);
                        };
                    };
                };
            };
        }
        private function loadImages(_arg1, _arg2):void{
            var picLoader:* = null;
            var ioError:* = null;
            var onLoadProgress:* = null;
            var onLoadComplete:* = null;
            var url:* = _arg1;
            var j:* = _arg2;
            ioError = function (_arg1:IOErrorEvent):void{
            };
            onLoadProgress = function (_arg1:ProgressEvent):void{
            };
            onLoadComplete = function (_arg1:Event):void{
                picLoader.content.width = 122;
                picLoader.content.height = 90;
                screencast.img[("img" + j)].addChild(picLoader.content);
            };
            var picURL:* = new URLRequest(url);
            picLoader = new Loader();
            picLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
            picLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
            picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            var loaderContext:* = new LoaderContext();
            loaderContext.checkPolicyFile = true;
            if (Security.sandboxType != "localTrusted"){
                loaderContext.applicationDomain = ApplicationDomain.currentDomain;
                loaderContext.securityDomain = SecurityDomain.currentDomain;
            };
            picLoader.load(picURL, loaderContext);
        }
        private function HD(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:int;
            this.openAdvertWindow();
            if (this.onTheRun){
                if (this.isHD == false){
                    this.file = this.xml_filehd;
                    this.pixel_hd.visible = true;
                    this.pixel_sd.visible = false;
                    if (this.infoObject.keyframes){
                        this.timeTick = this.stream.time;
                    } else {
                        if (this.infoObject.seekpoints){
                            this.timeTick = (this.timeTick + this.stream.time);
                        } else {
                            this.timeTick = this.stream.time;
                        };
                    };
                    clearInterval(this.intervalPosition);
                    this.stream.pause();
                    this.stream.play(this.file);
                    this.quality_back.y = 2;
                    this.currentX = this.square_btn.x;
                    this.loaded_line.x = this.currentX;
                    this.played_line.x = this.currentX;
                    this.click_line.x = this.currentX;
                    this.loaded_line.width = 1;
                    this.played_line.width = 1;
                    this.click_line.width = 1;
                    this.isHD = true;
                    this.quality_hq_btn.visible = true;
                    this.quality_lq_btn.visible = false;
                } else {
                    this.file = this.xml_filesd;
                    this.pixel_sd.visible = true;
                    this.pixel_hd.visible = false;
                    if (this.infoObject.keyframes){
                        this.timeTick = this.stream.time;
                    } else {
                        if (this.infoObject.seekpoints){
                            this.timeTick = (this.timeTick + this.stream.time);
                        } else {
                            this.timeTick = this.stream.time;
                        };
                    };
                    clearInterval(this.intervalPosition);
                    this.stream.pause();
                    this.stream.play(this.file);
                    this.quality_back.y = 20;
                    this.currentX = this.square_btn.x;
                    this.loaded_line.x = this.currentX;
                    this.played_line.x = this.currentX;
                    this.click_line.x = this.currentX;
                    this.loaded_line.width = 1;
                    this.played_line.width = 1;
                    this.click_line.width = 1;
                    this.isHD = false;
                    this.quality_lq_btn.visible = true;
                    this.quality_hq_btn.visible = false;
                };
                this.originalSize = null;
                this.thumb.visible = false;
                this.loadXCoeff = (this.currentX / (stage.stageWidth - this.TIMELINE_WIDTH));
                this.squareXCoeff = (this.square_btn.x / (stage.stageWidth - this.TIMELINE_WIDTH));
                this.isHDClick = true;
            };
        }
        private function StreamHD(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:int;
            this.openAdvertWindow();
            if (this.onTheRun){
                if (this.isHD == false){
                    this.file = this.xml_chanel_hd;
                    this.streams = this.xml_stream_hd;
                    this.group = this.xml_group_hd;
                    this.type = this.xml_type_hd;
                    this.pixel_hd.visible = true;
                    this.pixel_sd.visible = false;
                    this.quality_back.y = 2;
                    this.play_btn.visible = true;
                    if (this.type == "1"){
                        this.createConnectP2P();
                    } else {
                        this.createConnect();
                    };
                    this.isHD = true;
                    this.quality_hq_btn.visible = true;
                    this.quality_lq_btn.visible = false;
                } else {
                    this.file = this.xml_chanel_sd;
                    this.streams = this.xml_stream_sd;
                    this.group = this.xml_group_sd;
                    this.type = this.xml_type_sd;
                    this.pixel_sd.visible = true;
                    this.pixel_hd.visible = false;
                    this.quality_back.y = 20;
                    this.play_btn.visible = true;
                    if (this.type == "1"){
                        this.createConnectP2P();
                    } else {
                        this.createConnect();
                    };
                    this.isHD = false;
                    this.quality_lq_btn.visible = true;
                    this.quality_hq_btn.visible = false;
                };
                this.originalSize = null;
                this.thumb.visible = false;
            };
        }
        private function mouseUp(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:Number;
            if (this.isSquareScrub){
                if (this.square_btn.x < ((this.square_btn.width / 2) - 3)){
                    this.square_btn.x = ((this.square_btn.width / 2) - 3);
                } else {
                    if (this.square_btn.x > ((stage.stageWidth - (this.square_btn.width / 2)) - 3)){
                        this.square_btn.x = ((stage.stageWidth - (this.square_btn.width / 2)) + 3);
                    } else {
                        this.square_btn.x = this.square_btn.x;
                    };
                };
                if ((((this.square_btn.x > (this.loaded_line.x + this.loaded_line.width))) || ((this.square_btn.x < this.loaded_line.x)))){
                    if (this.back_off.mouseX < ((this.square_btn.width / 2) - 3)){
                        this.back_off_mouseX = ((this.square_btn.width / 2) - 3);
                    } else {
                        if (this.back_off.mouseX > ((this.ORIGINAL_WIDTH - (this.square_btn.width / 2)) - 3)){
                            this.back_off_mouseX = ((this.ORIGINAL_WIDTH - (this.square_btn.width / 2)) + 3);
                        } else {
                            this.back_off_mouseX = this.back_off.mouseX;
                        };
                    };
                    if (this.infoObject.keyframes){
                        this.keyframe = this.getNearestKeyframe(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.keyframes);
                        this.timeTick = this.infoObject.keyframes.times[this.keyframe];
                        this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                    } else {
                        if (this.infoObject.seekpoints){
                            this.keyframe = this.getNearestSeekpoint(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.seekPoints);
                            this.timeTick = this.seekPoints[this.keyframe]["time"];
                            this.stream.play(((this.file + "?start=") + this.seekPoints[this.keyframe]["time"]));
                        } else {
                            this.keyframe = this.getNearestKeyframe(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.keyframes);
                            this.timeTick = this.infoObject.keyframes.times[this.keyframe];
                            this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                        };
                    };
                    this.currentX = (this.back_off_mouseX * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH));
                    this.square_btn.x = (this.back_off_mouseX * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH));
                    _local2 = Math.round(((this.square_btn.x / this.back_off.width) * 100));
                    _local3 = Math.round(((this.videoDuration * _local2) / 100));
                    this.time_all.htmlText = ((this.formatTime(_local3) + " / ") + this.formatTime(this.videoDuration));
                    this.loaded_line.width = 0;
                    this.played_line.width = 0;
                    this.click_line.width = 0;
                    this.loaded_line.x = this.currentX;
                    this.played_line.x = this.currentX;
                    this.click_line.x = this.currentX;
                    this.loadXCoeff = (this.currentX / (stage.stageWidth - this.TIMELINE_WIDTH));
                    this.squareXCoeff = (this.square_btn.x / (stage.stageWidth - this.TIMELINE_WIDTH));
                    if (this.play_btn.visible == true){
                        this.stream.pause();
                    };
                } else {
                    this.sound_scrub_pos = Math.ceil(((this.square_btn.x / this.back_off.width) * this.videoDuration));
                    if (this.infoObject.keyframes){
                        this.stream.seek(this.sound_scrub_pos);
                        this.played_line.width = (this.square_btn.x - this.currentX);
                    } else {
                        if (this.infoObject.seekpoints){
                            this.stream.seek((this.sound_scrub_pos - this.timeTick));
                            this.played_line.width = (this.square_btn.x - this.currentX);
                        } else {
                            this.stream.seek(this.sound_scrub_pos);
                            this.played_line.width = (this.square_btn.x - this.currentX);
                        };
                    };
                    if (this.play_btn.visible == true){
                        this.stream.pause();
                    } else {
                        this.stream.resume();
                    };
                };
            };
            if (this.isVolumeScrub){
                removeEventListener(MouseEvent.MOUSE_MOVE, this.changeVolume);
            };
            this.isVolumeScrub = false;
            this.square_btn.stopDrag();
            this.hideTimes();
            this.isSquareScrub = false;
        }
        private function mouseMove(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:Number;
            if (this.isSquareScrub){
                if ((((this.back_off.mouseX > 0)) && ((this.back_off.mouseX < this.back_off.width)))){
                    if (this.infoObject.keyframes){
                        this.move_scrubx = Math.floor((this.back_off.mouseX * (this.back_off.width / this.ORIGINAL_WIDTH)));
                    } else {
                        if (this.infoObject.seekpoints){
                            this.move_scrubx = Math.floor((this.back_off.mouseX * (this.back_off.width / this.ORIGINAL_WIDTH)));
                        } else {
                            this.move_scrubx = Math.floor((this.back_off.mouseX * (this.back_off.width / this.ORIGINAL_WIDTH)));
                        };
                    };
                    if (this.move_scrubx < 0){
                        this.move_scrubx = 0;
                    };
                    if (this.move_scrubx > (this.back_off.width - 1)){
                        this.move_scrubx = (this.back_off.width - 1);
                    };
                    if (this.move_scrubx < ((this.square_btn.width / 2) - 3)){
                        this.square_btn.x = ((this.square_btn.width / 2) - 3);
                    } else {
                        if (this.move_scrubx > ((stage.stageWidth - (this.square_btn.width / 2)) - 3)){
                            this.square_btn.x = ((stage.stageWidth - (this.square_btn.width / 2)) + 3);
                        } else {
                            this.square_btn.x = this.move_scrubx;
                        };
                    };
                    _local2 = Math.round(((this.square_btn.x / this.back_off.width) * 100));
                    _local3 = Math.round(((this.videoDuration * _local2) / 100));
                    this.time_all.htmlText = ((this.formatTime(_local3) + " / ") + this.formatTime(this.videoDuration));
                };
            };
            if (this.onTheRun){
                if (this.isTimer == true){
                    this.timerPanel.reset();
                    this.timerPanel.start();
                    this.gotoUp();
                };
            };
        }
        private function startChangeVolume(_arg1:MouseEvent):void{
            this.openAdvertWindow();
            this.isVolumeScrub = true;
            addEventListener(MouseEvent.MOUSE_MOVE, this.changeVolume);
        }
        private function stopChangeVolume(_arg1:MouseEvent):void{
            removeEventListener(MouseEvent.MOUSE_MOVE, this.changeVolume);
        }
        private function changeVolume(_arg1:MouseEvent):void{
            var _local2:Number;
            if (this.sound_line_fon.mouseY > this.sound_line_fon.height){
                _local2 = this.sound_line_fon.height;
            } else {
                if (this.sound_line_fon.mouseY < 0){
                    _local2 = 0;
                } else {
                    _local2 = this.sound_line_fon.mouseY;
                };
            };
            this.square_sound.y = (_local2 + 11);
            this.saveSound = (1 - (this.sound_line_fon.mouseY / this.sound_line_fon.height));
            if (this.saveSound > 0){
                this.nomute.visible = true;
            } else {
                this.nomute.visible = false;
                this.saveSound = 0;
            };
            this.setVolume(this.saveSound);
        }
        private function clickVolume(_arg1:MouseEvent):void{
            this.openAdvertWindow();
            if (this.nomute.visible == false){
                this.tween_x = new Tween(this.square_sound, "y", Regular.easeOut, this.square_sound.y, (((1 - this.saveSound) * this.sound_line_fon.height) + 11), 0.3, true);
                this.nomute.visible = true;
                this.setVolume(this.saveSound);
            } else {
                this.tween_x = new Tween(this.square_sound, "y", Regular.easeOut, this.square_sound.y, (this.sound_line_fon.height + 11), 0.3, true);
                this.nomute.visible = false;
                this.setVolume(0);
            };
        }
        private function clickChangeVolume(_arg1:MouseEvent):void{
            this.square_sound.y = (this.sound_line_fon.mouseY + 11);
            this.saveSound = (1 - (this.sound_line_fon.mouseY / this.sound_line_fon.height));
            if (this.saveSound > 0){
                this.nomute.visible = true;
            } else {
                this.nomute.visible = false;
            };
            this.setVolume(this.saveSound);
        }
        private function timerVolumeOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function timerVolumeOnTimerComplete(_arg1:TimerEvent):void{
            this.timerVolume.reset();
            this.volume_h.visible = false;
        }
        private function timerQualityOnTick(_arg1:TimerEvent):void{
            var _local2:int = (_arg1.target.repeatCount - _arg1.target.currentCount);
        }
        private function timerQualityOnTimerComplete(_arg1:TimerEvent):void{
            this.timerQuality.reset();
            this.quality_choice.visible = false;
        }
        private function seeQuality(_arg1:MouseEvent):void{
            this.quality_choice.visible = true;
            this.timerQuality.stop();
            this.timerQuality.reset();
        }
        private function hideQuality(_arg1:MouseEvent):void{
            this.timerQuality.start();
        }
        private function seeVolume(_arg1:MouseEvent):void{
            this.volume_h.visible = true;
            this.timerVolume.stop();
            this.timerVolume.reset();
        }
        private function hideVolume(_arg1:MouseEvent):void{
            this.timerVolume.start();
        }
        private function streamStatus(_arg1:StatusEvent):void{
        }
        private function streamIOError(_arg1:IOErrorEvent):void{
        }
        private function progressHandler():void{
            var _local1:Number = (this.returnBytesLoaded() / this.returnBytesTotal());
            this.loaded_line.width = Math.floor((_local1 * (this.back_off.width - this.currentX)));
            this.click_line.width = Math.floor((_local1 * (this.back_off.width - this.currentX)));
        }
        public function returnBytesLoaded(){
            return (String(this.stream.bytesLoaded));
        }
        public function returnBytesTotal(){
            return (String(this.stream.bytesTotal));
        }
        private function netStatusHandlerP2P(_arg1:NetStatusEvent):void{
            switch (_arg1.info.code){
                case "NetConnection.Connect.Rejected":
                    break;
                case "NetConnection.Connect.Success":
                    this.formNetGroup();
                    break;
                case "NetConnection.Connect.Closed":
                    break;
                case "NetGroup.Connect.Success":
                    this.p2ptext.visible = false;
                    this.isP2Ptext = true;
                    this.createStreamP2P();
                    break;
                case "NetGroup.MulticastStream.PublishNotify":
                    break;
                case "NetGroup.MulticastStream.UnpublishNotify":
                    break;
                case "NetStream.Connect.Success":
                    break;
                case "NetStream.Play.Start":
                    this.back_off.buttonMode = true;
                    this.square_btn.buttonMode = true;
                    clearInterval(this.intervalHandler);
                    this.intervalHandler = setInterval(this.progressHandler, 1);
                    this.timerSeek.reset();
                    this.timerSeek.start();
                    this.thumb.visible = false;
                    break;
                case "NetStream.Play.Stop":
                    this.stopSound();
                    this.prerollNum++;
                    if (this.prerollNum < 2){
                        this.preroll = false;
                        this.onTheRun = false;
                        this.originalSize = null;
                        this.videoDuration = 0;
                        switch (this.videotype){
                            case "file":
                                this.createConnectFile();
                                break;
                            case "stream":
                                if (this.type == "1"){
                                    this.createConnectP2P();
                                } else {
                                    this.createConnect();
                                };
                                break;
                        };
                    };
                    break;
                case "NetStream.Buffer.Empty":
                    this.loading.visible = true;
                    break;
                case "NetStream.Buffer.Full":
                    this.loading.visible = false;
                    this.video.visible = true;
                    break;
                case "NetStream.Pause.Notify":
                    if (this.play_btn.visible == false){
                        this.loading.visible = true;
                    };
                    break;
                case "NetStream.Seek.InvalidTime":
                    if (this.play_btn.visible == false){
                        this.loading.visible = true;
                    };
                    break;
            };
        }
        private function netStatusHandler(_arg1:NetStatusEvent):void{
            switch (_arg1.info.code){
                case "NetStream.Play.StreamNotFound":
                    break;
                case "NetStream.Play.Start":
                    this.back_off.buttonMode = true;
                    this.square_btn.buttonMode = true;
                    clearInterval(this.intervalHandler);
                    this.intervalHandler = setInterval(this.progressHandler, 1);
                    this.loading.visible = false;
                    this.timerSeek.reset();
                    this.timerSeek.start();
                    this.thumb.visible = false;
                    break;
                case "NetStream.Play.Stop":
                    this.stopSound();
                    this.prerollNum++;
                    if (this.prerollNum < 2){
                        this.preroll = false;
                        this.onTheRun = false;
                        this.originalSize = null;
                        this.videoDuration = 0;
                        switch (this.videotype){
                            case "file":
                                this.createConnectFile();
                                break;
                            case "stream":
                                if (this.type == "1"){
                                    this.createConnectP2P();
                                } else {
                                    this.createConnect();
                                };
                                break;
                        };
                    };
                    break;
                case "NetStream.Buffer.Empty":
                    this.loading.visible = true;
                    break;
                case "NetStream.Buffer.Full":
                    this.loading.visible = false;
                    clearInterval(this.intervalPosition);
                    this.intervalPosition = setInterval(this.positionTimerHandler, 300);
                    this.video.visible = true;
                    break;
                case "NetStream.Pause.Notify":
                    if (this.play_btn.visible == false){
                        this.loading.visible = true;
                    };
                    break;
                case "NetStream.Seek.InvalidTime":
                    if (this.play_btn.visible == false){
                        this.loading.visible = true;
                    };
                    break;
            };
        }
        public function onMetaData(_arg1:Object):void{
            var _local2:String;
            this.label_txt.htmlText = "";
            this.log(("url: " + this.file), this.CONSOLE);
            this.infoObject = _arg1;
            for (_local2 in this.infoObject) {
                if (((!((this.infoObject[_local2] == undefined))) && (!((this.infoObject[_local2] == null))))){
                    this.log(((_local2 + ": ") + this.infoObject[_local2]), this.CONSOLE);
                };
            };
            if (!this.videoDuration){
                this.videoDuration = this.infoObject.duration;
            };
            if (this.infoObject.keyframes){
                if (!this.keyframes){
                    this.keyframes = this.infoObject.keyframes.times;
                    this.videoPositions = this.infoObject.keyframes.filepositions;
                };
            };
            if (this.infoObject.seekpoints){
                if (!this.seekPoints){
                    this.seekPoints = this.infoObject.seekpoints;
                };
            };
            if (!this.originalSize){
                if (!this.infoObject.width){
                    this.infoObject.width = stage.stageWidth;
                };
                if (!this.infoObject.height){
                    this.infoObject.height = stage.stageHeight;
                };
                this.originalSize = new Point(this.infoObject.width, this.infoObject.height);
            };
            if (this.originalSize){
                this.stagewidth = (stage.stageWidth / this.originalSize.x);
                this.stageheight = (stage.stageHeight / this.originalSize.y);
                if (this.stagewidth > this.stageheight){
                    this.vw = (this.originalSize.x * this.stageheight);
                    this.vh = (this.originalSize.y * this.stageheight);
                } else {
                    this.vw = (this.originalSize.x * this.stagewidth);
                    this.vh = (this.originalSize.y * this.stagewidth);
                };
                this.video.width = this.vw;
                this.video.height = this.vh;
                this.video.x = ((stage.stageWidth / 2) - (this.vw / 2));
                this.video.y = ((stage.stageHeight / 2) - (this.vh / 2));
            };
            if (this.isHDClick == true){
                this.stream.pause();
                if (this.infoObject.keyframes){
                    this.keyframe = this.getNearestKeyframe(this.timeTick, this.keyframes);
                    this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                } else {
                    if (this.infoObject.seekpoints){
                        this.keyframe = this.getNearestSeekpoint(this.timeTick, this.seekPoints);
                        this.stream.play(((this.file + "?start=") + this.seekPoints[this.keyframe]["time"]));
                    } else {
                        this.keyframe = this.getNearestKeyframe(this.timeTick, this.keyframes);
                        this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                    };
                };
                this.isHDClick = false;
                this.play_btn.visible = false;
                this.pause_btn.visible = true;
            };
        }
        public function onMetaDatas():void{
            if (!this.originalSize){
                this.originalSize = new Point(Number(this.stream_width), Number(this.stream_height));
            };
            if (this.originalSize){
                this.stagewidth = (stage.stageWidth / this.originalSize.x);
                this.stageheight = (stage.stageHeight / this.originalSize.y);
                if (this.stagewidth > this.stageheight){
                    this.vw = (this.originalSize.x * this.stageheight);
                    this.vh = (this.originalSize.y * this.stageheight);
                } else {
                    this.vw = (this.originalSize.x * this.stagewidth);
                    this.vh = (this.originalSize.y * this.stagewidth);
                };
                this.video.width = this.vw;
                this.video.height = this.vh;
                this.video.x = ((stage.stageWidth / 2) - (this.vw / 2));
                this.video.y = ((stage.stageHeight / 2) - (this.vh / 2));
            };
        }
        private function positionTimerHandler():void{
            var _local1:Number = Math.floor(((this.stream.time / this.videoDuration) * this.back_off.width));
            if (this.infoObject.keyframes){
                if ((((_local1 > ((this.square_btn.width / 2) - 3))) && ((_local1 < (this.back_off.width - ((this.square_btn.width / 2) - 3)))))){
                    this.square_btn.x = _local1;
                };
                this.played_line.width = (_local1 - this.currentX);
                this.time_all.htmlText = ((this.formatTime(this.stream.time) + " / ") + this.formatTime(this.videoDuration));
                this.second = this.stream.time;
            } else {
                if (this.infoObject.seekpoints){
                    if (((((this.currentX + _local1) > ((this.square_btn.width / 2) - 3))) && (((this.currentX + _local1) < (this.back_off.width - ((this.square_btn.width / 2) - 3)))))){
                        this.square_btn.x = (this.currentX + _local1);
                    };
                    this.played_line.width = _local1;
                    this.time_all.htmlText = ((this.formatTime((this.timeTick + this.stream.time)) + " / ") + this.formatTime(this.videoDuration));
                    this.second = (this.timeTick + this.stream.time);
                } else {
                    if ((((_local1 > ((this.square_btn.width / 2) - 3))) && ((_local1 < (this.back_off.width - ((this.square_btn.width / 2) - 3)))))){
                        this.square_btn.x = _local1;
                    };
                    this.played_line.width = (_local1 - this.currentX);
                    this.time_all.htmlText = ((this.formatTime(this.stream.time) + " / ") + this.formatTime(this.videoDuration));
                    this.second = this.stream.time;
                };
            };
            this.loadWidthCoeff = (this.loaded_line.width / (stage.stageWidth - this.TIMELINE_WIDTH));
            this.squareXCoeff = (this.square_btn.x / (stage.stageWidth - this.TIMELINE_WIDTH));
        }
        private function loadClick(_arg1:MouseEvent):void{
            var _local2:Tween;
            this.openAdvertWindow();
            clearInterval(this.intervalPosition);
            if ((((this.loaded_line.mouseX > 0)) && ((this.loaded_line.mouseX < this.back_off.width)))){
                if (this.infoObject.keyframes){
                    this.move_scrubx = (this.currentX + Math.floor((this.loaded_line.mouseX * (this.loaded_line.width / this.ORIGINAL_WIDTH))));
                } else {
                    if (this.infoObject.seekpoints){
                        this.move_scrubx = (this.currentX + Math.floor((this.loaded_line.mouseX * (this.loaded_line.width / this.ORIGINAL_WIDTH))));
                    } else {
                        this.move_scrubx = (this.currentX + Math.floor((this.loaded_line.mouseX * (this.loaded_line.width / this.ORIGINAL_WIDTH))));
                    };
                };
                if (this.move_scrubx < 0){
                    this.move_scrubx = 0;
                };
                if (this.move_scrubx > (this.back_off.width - 1)){
                    this.move_scrubx = (this.back_off.width - 1);
                };
                if (this.move_scrubx < ((this.square_btn.width / 2) - 3)){
                    this.square_btn.x = ((this.square_btn.width / 2) - 3);
                } else {
                    if (this.move_scrubx > ((stage.stageWidth - (this.square_btn.width / 2)) - 3)){
                        this.square_btn.x = ((stage.stageWidth - (this.square_btn.width / 2)) + 3);
                    } else {
                        this.square_btn.x = this.move_scrubx;
                    };
                };
                if (this.onTheRun == false){
                    _local2.addEventListener(TweenEvent.MOTION_FINISH, this.tweenScrubFinish);
                };
            };
            this.onScrubit(this.move_scrubx);
        }
        private function tweenScrubFinish(_arg1:TweenEvent){
            clearInterval(this.intervalPosition);
            this.intervalPosition = setInterval(this.positionTimerHandler, 200);
        }
        private function onScrubit(_arg1){
            this.sound_scrub_pos = Math.ceil(((_arg1 / this.back_off.width) * this.videoDuration));
            if (this.infoObject.keyframes){
                this.stream.seek(this.sound_scrub_pos);
                this.played_line.width = (_arg1 - this.currentX);
            } else {
                if (this.infoObject.seekpoints){
                    this.stream.seek((this.sound_scrub_pos - this.timeTick));
                    this.played_line.width = (_arg1 - this.currentX);
                } else {
                    this.stream.seek(this.sound_scrub_pos);
                    this.played_line.width = (_arg1 - this.currentX);
                };
            };
            var _local2:Number = Math.round(((this.square_btn.x / this.back_off.width) * 100));
            var _local3:Number = Math.round(((this.videoDuration * _local2) / 100));
            this.time_all.htmlText = ((this.formatTime(_local3) + " / ") + this.formatTime(this.videoDuration));
        }
        private function squareDown(_arg1:MouseEvent):void{
            if (((this.onTheRun) && ((this.timerSeek.currentCount > 1)))){
                clearInterval(this.intervalPosition);
                this.stream.pause();
                this.isSquareScrub = true;
                this.square_btn.startDrag(false, new Rectangle(((this.square_btn.width / 2) - 3), 4, ((this.back_off.width - this.square_btn.width) + 6), 0));
                this.seeTimes();
            };
        }
        private function backClick(_arg1:MouseEvent):void{
            var _local2:Number;
            var _local3:Number;
            if (((this.onTheRun) && ((this.timerSeek.currentCount > 1)))){
                clearInterval(this.intervalPosition);
                this.stream.pause();
                if (this.back_off.mouseX < ((this.square_btn.width / 2) - 3)){
                    this.back_off_mouseX = ((this.square_btn.width / 2) - 3);
                } else {
                    if (this.back_off.mouseX > ((this.ORIGINAL_WIDTH - (this.square_btn.width / 2)) - 3)){
                        this.back_off_mouseX = ((this.ORIGINAL_WIDTH - (this.square_btn.width / 2)) + 3);
                    } else {
                        this.back_off_mouseX = this.back_off.mouseX;
                    };
                };
                if (this.infoObject.keyframes){
                    this.keyframe = this.getNearestKeyframe(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.keyframes);
                    this.timeTick = this.infoObject.keyframes.times[this.keyframe];
                    this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                } else {
                    if (this.infoObject.seekpoints){
                        this.keyframe = this.getNearestSeekpoint(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.seekPoints);
                        this.timeTick = this.seekPoints[this.keyframe]["time"];
                        this.stream.play(((this.file + "?start=") + this.seekPoints[this.keyframe]["time"]));
                    } else {
                        this.keyframe = this.getNearestKeyframe(Math.floor((((this.back_off_mouseX * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.keyframes);
                        this.timeTick = this.infoObject.keyframes.times[this.keyframe];
                        this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
                    };
                };
                this.currentX = (this.back_off_mouseX * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH));
                this.square_btn.x = (this.back_off_mouseX * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH));
                _local2 = Math.round(((this.square_btn.x / this.back_off.width) * 100));
                _local3 = Math.round(((this.videoDuration * _local2) / 100));
                this.time_all.htmlText = ((this.formatTime(_local3) + " / ") + this.formatTime(this.videoDuration));
                this.loaded_line.width = 0;
                this.played_line.width = 0;
                this.click_line.width = 0;
                this.loaded_line.x = this.currentX;
                this.played_line.x = this.currentX;
                this.click_line.x = this.currentX;
                this.loadXCoeff = (this.currentX / (stage.stageWidth - this.TIMELINE_WIDTH));
                this.squareXCoeff = (this.square_btn.x / (stage.stageWidth - this.TIMELINE_WIDTH));
                if (this.play_btn.visible == true){
                    this.stream.pause();
                };
            };
        }
        private function replay(_arg1:MouseEvent):void{
            this.openAdvertWindow();
            clearInterval(this.intervalPosition);
            this.stream.pause();
            if (this.infoObject.keyframes){
                this.keyframe = this.getNearestKeyframe(Math.floor((((0 * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.keyframes);
                this.timeTick = this.infoObject.keyframes.times[this.keyframe];
                this.stream.play(((this.file + "?start=") + this.infoObject.keyframes.filepositions[this.keyframe]));
            } else {
                if (this.infoObject.seekpoints){
                    this.keyframe = this.getNearestSeekpoint(Math.floor((((0 * this.videoDuration) / this.back_off.width) * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH))), this.seekPoints);
                    this.timeTick = this.seekPoints[this.keyframe]["time"];
                    this.stream.play(((this.file + "?start=") + this.seekPoints[this.keyframe]["time"]));
                };
            };
            this.currentX = (0 * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH));
            this.square_btn.x = (((0 * ((stage.stageWidth - this.TIMELINE_WIDTH) / this.ORIGINAL_WIDTH)) + (this.square_btn.width / 2)) - 3);
            this.loaded_line.width = 0;
            this.played_line.width = 0;
            this.click_line.width = 0;
            this.loaded_line.x = this.currentX;
            this.played_line.x = this.currentX;
            this.click_line.x = this.currentX;
            this.loadXCoeff = (this.currentX / (stage.stageWidth - this.TIMELINE_WIDTH));
            this.squareXCoeff = (this.square_btn.x / (stage.stageWidth - this.TIMELINE_WIDTH));
            this.back_related.visible = false;
            this.big_reload_btn.visible = false;
            this.related.hideRelated();
            this.video.visible = true;
            this.play_btn.visible = false;
            this.pause_btn.visible = true;
            this.thumb.visible = false;
            this.advertBlock();
        }
        public function setVolume(_arg1:Number):void{
            this.saveVolume.setLevelVolume(_arg1);
            var _local2:SoundTransform = new SoundTransform(_arg1);
            _local2.volume = _arg1;
            this.stream.soundTransform = _local2;
        }
        private function play_pause(_arg1:MouseEvent):void{
            this.openAdvertWindow();
            switch (this.videotype){
                case "file":
                    if (!this.preroll){
                        this.playSound();
                    } else {
                        this.XMLADVERT.configXML(((this.scriptAdvertURL + "?sessid=") + this.sessid));
                        this.curNumAdvert++;
                    };
                    break;
                case "stream":
                    if (!this.preroll){
                        if (this.type == "1"){
                            this.createConnectP2P();
                        } else {
                            this.createConnect();
                        };
                    } else {
                        this.XMLADVERT.configXML(((this.scriptAdvertURL + "?sessid=") + this.sessid));
                        this.curNumAdvert++;
                    };
                    break;
            };
        }
        private function playSound():void{
            if (this.play_btn.visible){
                switch (this.videotype){
                    case "file":
                        if (this.onTheRun){
                            this.stream.resume();
                        } else {
                            this.loading.visible = true;
                            this.onTheRun = true;
                            this.stream.play(this.file);
                        };
                        break;
                    case "stream":
                        if (this.type == "1"){
                        } else {
                            if (this.onTheRun){
                                this.stopSound();
                            };
                        };
                        this.loading.visible = true;
                        this.onTheRun = true;
                        if (this.type == "1"){
                            this.stream.play(this.file);
                        } else {
                            this.stream.play(this.file, -1);
                        };
                        break;
                };
                if (this.nomute.visible == true){
                    this.setVolume(this.saveSound);
                } else {
                    this.setVolume(0);
                };
                this.play_btn.visible = false;
                this.pause_btn.visible = true;
                this.big_play_btn.visible = false;
                this.thumb.visible = false;
                this.isTimer = true;
                this.video.visible = true;
            } else {
                switch (this.videotype){
                    case "file":
                        this.stream.pause();
                        break;
                    case "stream":
                        this.stopSound();
                        break;
                };
                this.play_btn.visible = true;
                this.pause_btn.visible = false;
                this.big_play_btn.visible = true;
                this.thumb.visible = true;
                this.gotoUp();
                this.isTimer = false;
                this.video.visible = false;
            };
        }
        private function stopSound():void{
            var _local1:Number;
            var _local2:Number;
            this.openAdvertWindow();
            switch (this.videotype){
                case "file":
                    if (this.preroll){
                    } else {
                        this.related.seeRelated();
                        this.back_related.visible = true;
                        this.big_reload_btn.visible = true;
                        if (this.advert_top_mode != null){
                            this.advert1.stopTimerShow();
                        };
                        if (this.advert_bottom_mode != null){
                            this.advert2.stopTimerShow();
                        };
                        if (this.advert_left_mode != null){
                            this.advert3.stopTimerShow();
                        };
                        if (this.advert_right_mode != null){
                            this.advert4.stopTimerShow();
                        };
                    };
                    clearInterval(this.intervalPosition);
                    this.play_btn.visible = true;
                    this.pause_btn.visible = false;
                    this.stream.pause();
                    this.stream.seek(1);
                    this.loading.visible = false;
                    this.video.visible = false;
                    this.thumb.visible = true;
                    this.played_line.width = 1;
                    this.loaded_line.width = 1;
                    this.click_line.width = 1;
                    this.square_btn.x = ((this.currentX + (this.square_btn.width / 2)) - 3);
                    _local1 = Math.round(((this.square_btn.x / this.back_off.width) * 100));
                    _local2 = Math.round(((this.videoDuration * _local1) / 100));
                    this.time_all.htmlText = ((this.formatTime(_local2) + " / ") + this.formatTime(this.videoDuration));
                    break;
                case "stream":
                    this.play_btn.visible = true;
                    this.pause_btn.visible = false;
                    this.loading.visible = false;
                    this.video.visible = false;
                    this.thumb.visible = true;
                    if (this.type == "1"){
                        this.stream.close();
                    } else {
                        this.stream.pause();
                        this.stream.close();
                        this.connection.close();
                    };
                    break;
            };
        }
        private function formatTime(_arg1:int):String{
            var _local2:int = Math.round(_arg1);
            var _local3:int;
            if (_local2 > 0){
                while (_local2 > 59) {
                    _local3++;
                    _local2 = (_local2 - 60);
                };
                return (String((((((((_local3 < 10)) ? "" : "") + _local3) + ":") + (((_local2 < 10)) ? "0" : "")) + _local2)));
            };
            return ("0:00");
        }
        private function loadThumb(_arg1:String):void{
            this.loader = new Loader();
            this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, this.onLoadThumb);
            this.loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, this.progressThumb);
            this.loader.load(new URLRequest(_arg1));
        }
        private function progressThumb(_arg1:ProgressEvent):void{
        }
        private function onLoadThumb(_arg1:Event):void{
            this.twidth = (stage.stageWidth / this.loader.width);
            this.theight = (stage.stageHeight / this.loader.height);
            if (this.twidth > this.theight){
                this.tw = (this.loader.width * this.theight);
                this.th = (this.loader.height * this.theight);
            } else {
                this.tw = (this.loader.width * this.twidth);
                this.th = (this.loader.height * this.twidth);
            };
            this.thumb.width = this.tw;
            this.thumb.height = this.th;
            this.thumb.x = ((stage.stageWidth / 2) - (this.tw / 2));
            this.thumb.y = ((stage.stageHeight / 2) - (this.th / 2));
            this.thumb.addChild(this.loader);
            this.resizePlayer();
        }
        private function clickURL(_arg1:ContextMenuEvent):void{
            this.requestURL("http://tvforsite.net");
        }
        private function clickLogo(_arg1:MouseEvent):void{
            this.requestURL(this.xml_logo_url);
        }
        private function clickThumb(_arg1:MouseEvent):void{
            this.requestURL(this.xml_thumb_url);
        }
        private function requestURL(_arg1):void{
            var _local2:URLRequest = new URLRequest(_arg1);
            try {
                navigateToURL(_local2, "_blank");
            } catch(e) {
            };
        }
        private function keyPressed(_arg1:KeyboardEvent):void{
            if ((((_arg1.ctrlKey == true)) && ((_arg1.keyCode == 68)))){
                if (this.label_txt.visible == true){
                    this.label_txt.visible = false;
                } else {
                    this.label_txt.visible = true;
                };
            };
            if ((((_arg1.keyCode == Keyboard.SPACE)) && (!(this.preroll)))){
                this.openAdvertWindow();
                if (((this.play_btn.visible) && (!(this.isOpenPanel)))){
                    this.timerPanel.reset();
                    this.timerPanel.start();
                };
                switch (this.videotype){
                    case "file":
                        this.playSound();
                        break;
                    case "stream":
                        if (this.play_btn.visible == false){
                            this.playSound();
                        } else {
                            if (this.type == "1"){
                                this.createConnectP2P();
                            } else {
                                this.createConnect();
                            };
                        };
                        break;
                };
            };
        }
        private function fullScreen(_arg1:MouseEvent):void{
            this.openAdvertWindow();
            if (stage.displayState == StageDisplayState.NORMAL){
                stage.displayState = StageDisplayState.FULL_SCREEN;
            } else {
                stage.displayState = StageDisplayState.NORMAL;
            };
            this.resizePlayer();
        }
        public function fullScreenRedraw(_arg1:FullScreenEvent):void{
            if (stage.displayState == StageDisplayState.NORMAL){
                this.normal_btn.visible = false;
                this.fullscreen_btn.visible = true;
            } else {
                this.normal_btn.visible = true;
                this.fullscreen_btn.visible = false;
            };
            TweenMax.to(this.top_panel, 0.5, {
                y:0,
                ease:Cubic.easeOut
            });
            TweenMax.to(this.panel, 0.5, {
                y:(stage.stageHeight - 28),
                ease:Cubic.easeOut
            });
        }
        private function selectedText():void{
            var _local1:TextFieldColor = new TextFieldColor(this.label_txt, this.textColor, this.selectionColor, this.selectedColor);
            _local1.selectionColor = this.selectionColor;
            _local1.selectedColor = this.selectedColor;
        }
        private function selectedTextBlog():void{
            var _local1:TextFieldColor = new TextFieldColor(this.blog_txt, this.textColor, this.selectionColor, this.selectedColor);
            _local1.selectionColor = this.selectionColor;
            _local1.selectedColor = this.selectedColor;
            var _local2:TextFieldColor = new TextFieldColor(this.code_txt, this.textColor, this.selectionColor, this.selectedColor);
            _local2.selectionColor = this.selectionColor;
            _local2.selectedColor = this.selectedColor;
            var _local3:TextFieldColor = new TextFieldColor(this.url_txt, this.textColor, this.selectionColor, this.selectedColor);
            _local3.selectionColor = this.selectionColor;
            _local3.selectedColor = this.selectedColor;
        }
        public function resizeHandler(_arg1:Event):void{
            this.resizePlayer();
        }
        public function resizePlayer():void{
            this.advert1.resizeAdvert();
            this.advert2.resizeAdvert();
            this.advert3.resizeAdvert();
            this.advert4.resizeAdvert();
            if (this.row_pic.length > 0){
                this.related.resizeRelated();
            };
            this.big_pause_btn.x = Math.round(((stage.stageWidth / 2) - (this.big_pause_btn.width / 2)));
            this.big_pause_btn.y = Math.round(((stage.stageHeight / 2) - (this.big_pause_btn.height / 2)));
            this.big_play_btn.x = Math.round(((stage.stageWidth / 2) - (this.big_play_btn.width / 2)));
            this.big_play_btn.y = Math.round(((stage.stageHeight / 2) - (this.big_play_btn.height / 2)));
            this.p2ptext.x = ((this.big_play_btn.x - (this.p2ptext.width / 2)) + (this.big_play_btn.width / 2));
            this.p2ptext.y = ((this.big_play_btn.y - this.p2ptext.height) - (this.big_play_btn.height / 2));
            this.big_time_btn.x = Math.round(((stage.stageWidth / 2) - (this.big_time_btn.width / 2)));
            this.big_time_btn.y = Math.round(((stage.stageHeight / 2) - (this.big_time_btn.height / 2)));
            this.big_reload_btn.x = Math.round(((stage.stageWidth / 2) - (this.big_reload_btn.width / 2)));
            if (stage.displayState == StageDisplayState.NORMAL){
                this.big_reload_btn.y = Math.round((((stage.stageHeight / 2) - (this.big_reload_btn.height / 2)) - ((this.big_play_btn.height / 2) * 1.5)));
            } else {
                this.big_reload_btn.y = Math.round(((stage.stageHeight / 2) - (this.big_reload_btn.height / 2)));
            };
            this.back_panel.width = Math.round(stage.stageWidth);
            this.top_back_panel.width = Math.round(stage.stageWidth);
            this.top_panel.title.width = Math.round(stage.stageWidth);
            this.advert_close.x = Math.round(((stage.stageWidth - this.advert_close.width) - 14));
            this.fullscreen_btn.x = Math.round(((stage.stageWidth - this.fullscreen_btn.width) - 3));
            this.normal_btn.x = Math.round(((stage.stageWidth - this.normal_btn.width) - 3));
            this.quality_hq_btn.x = Math.round(((this.normal_btn.x - this.quality_hq_btn.width) - 19));
            this.quality_lq_btn.x = Math.round(((this.normal_btn.x - this.quality_lq_btn.width) - 19));
            this.quality.x = Math.round(((this.normal_btn.x - this.quality.width) - 3));
            this.vblog_btn.x = Math.round(((this.quality.x - this.vblog_btn.width) - 2));
            this.panel.line_vblog.x = Math.round((this.vblog_btn.x - 2));
            this.quality_choice.x = Math.round((this.quality.x + 3));
            this.time_all.x = Math.round((this.quality.x - 248));
            this.panel.y = Math.round((stage.stageHeight - 28));
            if (this.xml_thumb != ""){
                this.twidth = (stage.stageWidth / this.loader.width);
                this.theight = (stage.stageHeight / this.loader.height);
                if (this.twidth > this.theight){
                    this.tw = (this.loader.width * this.theight);
                    this.th = (this.loader.height * this.theight);
                } else {
                    this.tw = (this.loader.width * this.twidth);
                    this.th = (this.loader.height * this.twidth);
                };
                this.thumb.width = this.tw;
                this.thumb.height = this.th;
                this.thumb.x = ((stage.stageWidth / 2) - (this.tw / 2));
                this.thumb.y = ((stage.stageHeight / 2) - (this.th / 2));
            };
            this.loading.x = (stage.stageWidth / 2);
            this.loading.y = (stage.stageHeight / 2);
            if (this.originalSize){
                this.stagewidth = (stage.stageWidth / this.originalSize.x);
                this.stageheight = (stage.stageHeight / this.originalSize.y);
                if (this.stagewidth > this.stageheight){
                    this.vw = (this.originalSize.x * this.stageheight);
                    this.vh = (this.originalSize.y * this.stageheight);
                } else {
                    this.vw = (this.originalSize.x * this.stagewidth);
                    this.vh = (this.originalSize.y * this.stagewidth);
                };
                this.video.width = this.vw;
                this.video.height = this.vh;
                this.video.x = ((stage.stageWidth / 2) - (this.vw / 2));
                this.video.y = ((stage.stageHeight / 2) - (this.vh / 2));
            };
            this.back.width = stage.stageWidth;
            this.back.height = stage.stageHeight;
            this.back_related.width = stage.stageWidth;
            this.back_related.height = stage.stageHeight;
            this.back_off.width = stage.stageWidth;
            this.popup.y = (stage.stageHeight - 53);
            this.screencast.y = (stage.stageHeight - 155);
            this.vblog.x = ((stage.stageWidth / 2) - (this.vblog.width / 2));
            this.vblog.y = ((stage.stageHeight / 2) - (this.vblog.height / 2));
            switch (this.xml_logo_position){
                case "left-up":
                    this.logo.x = 0;
                    this.logo.y = 0;
                    break;
                case "left-down":
                    this.logo.x = 0;
                    this.logo.y = (stage.stageHeight - this.logo.height);
                    break;
                case "right-up":
                    this.logo.x = (stage.stageWidth - this.logo.width);
                    this.logo.y = 0;
                    break;
                case "right-down":
                    this.logo.x = (stage.stageWidth - this.logo.width);
                    this.logo.y = (stage.stageHeight - this.logo.height);
                    break;
            };
            this.loaded_line.x = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.loadXCoeff);
            this.loaded_line.width = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.loadWidthCoeff);
            this.click_line.x = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.loadXCoeff);
            this.click_line.width = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.loadWidthCoeff);
            this.played_line.x = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.loadXCoeff);
            if (this.currentX < ((this.square_btn.width / 2) - 3)){
                this.square_btn.x = ((this.square_btn.width / 2) - 3);
            } else {
                this.square_btn.x = ((stage.stageWidth - this.TIMELINE_WIDTH) * this.squareXCoeff);
            };
            this.played_line.width = (this.square_btn.x - this.played_line.x);
            this.currentX = this.loaded_line.x;
        }
        public function createLabelTexField():void{
            this.label_txt = new TextField();
            this.label_txt.autoSize = TextFieldAutoSize.LEFT;
            this.label_txt.multiline = true;
            var _local1:TextFormat = new TextFormat();
            _local1.font = "Verdana";
            _local1.color = "0xFFFFFF";
            _local1.size = 10;
            _local1.underline = false;
            this.label_txt.defaultTextFormat = _local1;
            this.label_txt.mouseEnabled = true;
            addChild(this.label_txt);
        }
        public function log(_arg1, _arg2:Boolean=false):void{
            if (_arg2){
                this.label_txt.htmlText = (this.label_txt.htmlText + (("" + _arg1) + "<br>"));
                trace((("" + _arg1) + "\n"));
            };
        }
        public function protect():void{
            var _local1:Date = new Date(2012, 4, 15, 0, 0, 0);
            var _local2:Date = new Date();
            if (_local2.time >= _local1.time){
                this.log("The Version is not registered. Necessary to buy license http://www.free-lance.ru/users/sergey_59rg", this.CONSOLE);
                this.core.visible = false;
            };
        }

    }
}//package classes 
﻿package classes {
    import flash.text.*;
    import flash.filters.*;

    public class TextFieldColor {

        private static const byteToPerc:Number = 0.00392156862745098;

        private var $textField:TextField;
        private var $textColor:uint;
        private var $selectedColor:uint;
        private var $selectionColor:uint;
        private var colorMatrixFilter:ColorMatrixFilter;

        public function TextFieldColor(_arg1:TextField, _arg2:uint=0, _arg3:uint=0, _arg4:uint=0){
            this.$textField = _arg1;
            this.colorMatrixFilter = new ColorMatrixFilter();
            this.$textColor = _arg2;
            this.$selectionColor = _arg3;
            this.$selectedColor = _arg4;
            this.updateFilter();
        }
        private static function splitRGB(_arg1:uint):Array{
            return ([((_arg1 >> 16) & 0xFF), ((_arg1 >> 8) & 0xFF), (_arg1 & 0xFF)]);
        }

        public function set textField(_arg1:TextField):void{
            this.$textField = _arg1;
        }
        public function get textField():TextField{
            return (this.$textField);
        }
        public function set textColor(_arg1:uint):void{
            this.$textColor = _arg1;
            this.updateFilter();
        }
        public function get textColor():uint{
            return (this.$textColor);
        }
        public function set selectionColor(_arg1:uint):void{
            this.$selectionColor = _arg1;
            this.updateFilter();
        }
        public function get selectionColor():uint{
            return (this.$selectionColor);
        }
        public function set selectedColor(_arg1:uint):void{
            this.$selectedColor = _arg1;
            this.updateFilter();
        }
        public function get selectedColor():uint{
            return (this.$selectedColor);
        }
        private function updateFilter():void{
            this.$textField.textColor = 0xFF0000;
            var _local1:Array = splitRGB(this.$selectionColor);
            var _local2:Array = splitRGB(this.$textColor);
            var _local3:Array = splitRGB(this.$selectedColor);
            var _local4:int = _local1[0];
            var _local5:int = _local1[1];
            var _local6:int = _local1[2];
            var _local7:Number = ((((_local2[0] - 0xFF) - _local1[0]) * byteToPerc) + 1);
            var _local8:Number = ((((_local2[1] - 0xFF) - _local1[1]) * byteToPerc) + 1);
            var _local9:Number = ((((_local2[2] - 0xFF) - _local1[2]) * byteToPerc) + 1);
            var _local10:Number = (((((_local3[0] - 0xFF) - _local1[0]) * byteToPerc) + 1) - _local7);
            var _local11:Number = (((((_local3[1] - 0xFF) - _local1[1]) * byteToPerc) + 1) - _local8);
            var _local12:Number = (((((_local3[2] - 0xFF) - _local1[2]) * byteToPerc) + 1) - _local9);
            this.colorMatrixFilter.matrix = [_local7, _local10, 0, 0, _local4, _local8, _local11, 0, 0, _local5, _local9, _local12, 0, 0, _local6, 0, 0, 0, 1, 0];
            this.$textField.filters = [this.colorMatrixFilter];
        }

    }
}//package classes 
﻿package {
    import flash.display.*;

    public dynamic class m_screencast_img extends MovieClip {

    }
}//package 
﻿package {
    import flash.display.*;

    public dynamic class m_screencast extends MovieClip {

        public var img:m_screencast_img;

    }
}//package 
﻿package {
    import flash.display.*;

    public dynamic class preloader_block extends MovieClip {

    }
}//package 
﻿package {
    import flash.display.*;

    public dynamic class m_site extends MovieClip {

    }
}//package 
﻿package {
    import flash.display.*;
    import flash.text.*;
    import flash.media.*;

    public dynamic class TvForsitePlayerCore extends MovieClip {

        public var logo:MovieClip;
        public var big_reload_btn:MovieClip;
        public var top_panel:MovieClip;
        public var ptext:TextField;
        public var big_play_btn:MovieClip;
        public var big_time_btn:MovieClip;
        public var thumb:MovieClip;
        public var panel:MovieClip;
        public var preloader:MovieClip;
        public var back_related:MovieClip;
        public var vblog:MovieClip;
        public var big_pause_btn:MovieClip;
        public var vidDisplay:Video;
        public var back:MovieClip;

    }
}//package 
﻿package {
    import flash.display.*;
    import flash.text.*;

    public dynamic class Advert2PlayerCore extends MovieClip {

        public var adv_pic:MovieClip;
        public var adv_mask:MovieClip;
        public var hint_ad_text:TextField;
        public var hint_ad_bg:MovieClip;
        public var hint_ad_close:SimpleButton;
        public var hint_ad_url:TextField;

    }
}//package 
﻿package {
    import flash.display.*;
    import flash.text.*;

    public dynamic class m_conteiner extends MovieClip {

        public var t1:TextField;
        public var t2:TextField;
        public var mc_shade:MovieClip;
        public var mc_img:MovieClip;
        public var mc_activity:preloader_block;

    }
}//package 
﻿package {
    import flash.display.*;

    public dynamic class RelatedPlayerCore extends MovieClip {

        public var related_slider:MovieClip;
        public var related_right:MovieClip;
        public var related_left:MovieClip;
        public var maska:MovieClip;
        public var mc_conteiner:m_conteiner;

    }
}//package 
﻿package {
    import flash.display.*;
    import flash.text.*;

    public dynamic class m_popup extends MovieClip {

        public var time:TextField;

    }
}//package 
﻿package fl.transitions.easing {

    public class Regular {

        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / _arg4);
            return ((((_arg3 * _arg1) * _arg1) + _arg2));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / _arg4);
            return ((((-(_arg3) * _arg1) * (_arg1 - 2)) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / (_arg4 / 2));
            if (_arg1 < 1){
                return (((((_arg3 / 2) * _arg1) * _arg1) + _arg2));
            };
            --_arg1;
            return ((((-(_arg3) / 2) * ((_arg1 * (_arg1 - 2)) - 1)) + _arg2));
        }

    }
}//package fl.transitions.easing 
﻿package fl.transitions {
    import flash.events.*;

    public class TweenEvent extends Event {

        public static const MOTION_START:String = "motionStart";
        public static const MOTION_STOP:String = "motionStop";
        public static const MOTION_FINISH:String = "motionFinish";
        public static const MOTION_CHANGE:String = "motionChange";
        public static const MOTION_RESUME:String = "motionResume";
        public static const MOTION_LOOP:String = "motionLoop";

        public var time:Number = NaN;
        public var position:Number = NaN;

        public function TweenEvent(_arg1:String, _arg2:Number, _arg3:Number, _arg4:Boolean=false, _arg5:Boolean=false){
            super(_arg1, _arg4, _arg5);
            this.time = _arg2;
            this.position = _arg3;
        }
        override public function clone():Event{
            return (new TweenEvent(this.type, this.time, this.position, this.bubbles, this.cancelable));
        }

    }
}//package fl.transitions 
﻿package fl.transitions {
    import flash.display.*;
    import flash.events.*;
    import flash.utils.*;

    public class Tween extends EventDispatcher {

        protected static var _mc:MovieClip = new MovieClip();

        public var isPlaying:Boolean = false;
        public var obj:Object = null;
        public var prop:String = "";
        public var func:Function;
        public var begin:Number = NaN;
        public var change:Number = NaN;
        public var useSeconds:Boolean = false;
        public var prevTime:Number = NaN;
        public var prevPos:Number = NaN;
        public var looping:Boolean = false;
        private var _duration:Number = NaN;
        private var _time:Number = NaN;
        private var _fps:Number = NaN;
        private var _position:Number = NaN;
        private var _startTime:Number = NaN;
        private var _intervalID:uint = 0;
        private var _finish:Number = NaN;
        private var _timer:Timer = null;

        public function Tween(_arg1:Object, _arg2:String, _arg3:Function, _arg4:Number, _arg5:Number, _arg6:Number, _arg7:Boolean=false){
            this.func = function (_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
                return ((((_arg3 * _arg1) / _arg4) + _arg2));
            };
            super();
            if (!arguments.length){
                return;
            };
            this.obj = _arg1;
            this.prop = _arg2;
            this.begin = _arg4;
            this.position = _arg4;
            this.duration = _arg6;
            this.useSeconds = _arg7;
            if ((_arg3 is Function)){
                this.func = _arg3;
            };
            this.finish = _arg5;
            this._timer = new Timer(100);
            this.start();
        }
        public function get time():Number{
            return (this._time);
        }
        public function set time(_arg1:Number):void{
            this.prevTime = this._time;
            if (_arg1 > this.duration){
                if (this.looping){
                    this.rewind((_arg1 - this._duration));
                    this.update();
                    this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_LOOP, this._time, this._position));
                } else {
                    if (this.useSeconds){
                        this._time = this._duration;
                        this.update();
                    };
                    this.stop();
                    this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_FINISH, this._time, this._position));
                };
            } else {
                if (_arg1 < 0){
                    this.rewind();
                    this.update();
                } else {
                    this._time = _arg1;
                    this.update();
                };
            };
        }
        public function get duration():Number{
            return (this._duration);
        }
        public function set duration(_arg1:Number):void{
            this._duration = ((_arg1)<=0) ? Infinity : _arg1;
        }
        public function get FPS():Number{
            return (this._fps);
        }
        public function set FPS(_arg1:Number):void{
            var _local2:Boolean = this.isPlaying;
            this.stopEnterFrame();
            this._fps = _arg1;
            if (_local2){
                this.startEnterFrame();
            };
        }
        public function get position():Number{
            return (this.getPosition(this._time));
        }
        public function set position(_arg1:Number):void{
            this.setPosition(_arg1);
        }
        public function getPosition(_arg1:Number=NaN):Number{
            if (isNaN(_arg1)){
                _arg1 = this._time;
            };
            return (this.func(_arg1, this.begin, this.change, this._duration));
        }
        public function setPosition(_arg1:Number):void{
            this.prevPos = this._position;
            if (this.prop.length){
                this.obj[this.prop] = (this._position = _arg1);
            };
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_CHANGE, this._time, this._position));
        }
        public function get finish():Number{
            return ((this.begin + this.change));
        }
        public function set finish(_arg1:Number):void{
            this.change = (_arg1 - this.begin);
        }
        public function continueTo(_arg1:Number, _arg2:Number):void{
            this.begin = this.position;
            this.finish = _arg1;
            if (!isNaN(_arg2)){
                this.duration = _arg2;
            };
            this.start();
        }
        public function yoyo():void{
            this.continueTo(this.begin, this.time);
        }
        protected function startEnterFrame():void{
            var _local1:Number;
            if (isNaN(this._fps)){
                _mc.addEventListener(Event.ENTER_FRAME, this.onEnterFrame, false, 0, true);
            } else {
                _local1 = (1000 / this._fps);
                this._timer.delay = _local1;
                this._timer.addEventListener(TimerEvent.TIMER, this.timerHandler, false, 0, true);
                this._timer.start();
            };
            this.isPlaying = true;
        }
        protected function stopEnterFrame():void{
            if (isNaN(this._fps)){
                _mc.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            } else {
                this._timer.stop();
            };
            this.isPlaying = false;
        }
        public function start():void{
            this.rewind();
            this.startEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_START, this._time, this._position));
        }
        public function stop():void{
            this.stopEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_STOP, this._time, this._position));
        }
        public function resume():void{
            this.fixTime();
            this.startEnterFrame();
            this.dispatchEvent(new TweenEvent(TweenEvent.MOTION_RESUME, this._time, this._position));
        }
        public function rewind(_arg1:Number=0):void{
            this._time = _arg1;
            this.fixTime();
            this.update();
        }
        public function fforward():void{
            this.time = this._duration;
            this.fixTime();
        }
        public function nextFrame():void{
            if (this.useSeconds){
                this.time = ((getTimer() - this._startTime) / 1000);
            } else {
                this.time = (this._time + 1);
            };
        }
        protected function onEnterFrame(_arg1:Event):void{
            this.nextFrame();
        }
        protected function timerHandler(_arg1:TimerEvent):void{
            this.nextFrame();
            _arg1.updateAfterEvent();
        }
        public function prevFrame():void{
            if (!this.useSeconds){
                this.time = (this._time - 1);
            };
        }
        private function fixTime():void{
            if (this.useSeconds){
                this._startTime = (getTimer() - (this._time * 1000));
            };
        }
        private function update():void{
            this.setPosition(this.getPosition(this._time));
        }

    }
}//package fl.transitions 
﻿package com.greensock {
    import flash.display.*;
    import flash.events.*;
    import com.greensock.core.*;
    import com.greensock.plugins.*;
    import com.greensock.events.*;
    import flash.utils.*;

    public class TweenMax extends TweenLite implements IEventDispatcher {

        public static const version:Number = 11.66;

        private static var _overwriteMode:int = ((OverwriteManager.enabled) ? OverwriteManager.mode : OverwriteManager.init(2));
;
        public static var killTweensOf:Function = TweenLite.killTweensOf;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;

        protected var _dispatcher:EventDispatcher;
        protected var _hasUpdateListener:Boolean;
        protected var _repeat:int = 0;
        protected var _repeatDelay:Number = 0;
        protected var _cyclesComplete:int = 0;
        protected var _easePower:int;
        protected var _easeType:int;
        public var yoyo:Boolean;

        public function TweenMax(_arg1:Object, _arg2:Number, _arg3:Object){
            super(_arg1, _arg2, _arg3);
            if (TweenLite.version < 11.2){
                throw (new Error("TweenMax error! Please update your TweenLite class or try deleting your ASO files. TweenMax requires a more recent version. Download updates at http://www.TweenMax.com."));
            };
            this.yoyo = Boolean(this.vars.yoyo);
            this._repeat = uint(this.vars.repeat);
            this._repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            this.cacheIsDirty = true;
            if (((((((((((this.vars.onCompleteListener) || (this.vars.onInitListener))) || (this.vars.onUpdateListener))) || (this.vars.onStartListener))) || (this.vars.onRepeatListener))) || (this.vars.onReverseCompleteListener))){
                this.initDispatcher();
                if ((((_arg2 == 0)) && ((_delay == 0)))){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                };
            };
            if (((this.vars.timeScale) && (!((this.target is TweenCore))))){
                this.cachedTimeScale = this.vars.timeScale;
            };
        }
        public static function to(_arg1:Object, _arg2:Number, _arg3:Object):TweenMax{
            return (new TweenMax(_arg1, _arg2, _arg3));
        }
        public static function from(_arg1:Object, _arg2:Number, _arg3:Object):TweenMax{
            _arg3.runBackwards = true;
            if (!("immediateRender" in _arg3)){
                _arg3.immediateRender = true;
            };
            return (new TweenMax(_arg1, _arg2, _arg3));
        }
        public static function fromTo(_arg1:Object, _arg2:Number, _arg3:Object, _arg4:Object):TweenMax{
            _arg4.startAt = _arg3;
            if (_arg3.immediateRender){
                _arg4.immediateRender = true;
            };
            return (new TweenMax(_arg1, _arg2, _arg4));
        }
        public static function allTo(_arg1:Array, _arg2:Number, _arg3:Object, _arg4:Number=0, _arg5:Function=null, _arg6:Array=null):Array{
            var i:* = 0;
            var varsDup:* = null;
            var p:* = null;
            var onCompleteProxy:* = null;
            var onCompleteParamsProxy:* = null;
            var targets:* = _arg1;
            var duration:* = _arg2;
            var vars:* = _arg3;
            var stagger:int = _arg4;
            var onCompleteAll = _arg5;
            var onCompleteAllParams = _arg6;
            var l:* = targets.length;
            var a:* = [];
            var curDelay:* = ((("delay" in vars)) ? Number(vars.delay) : 0);
            onCompleteProxy = vars.onComplete;
            onCompleteParamsProxy = vars.onCompleteParams;
            var lastIndex:* = (l - 1);
            i = 0;
            while (i < l) {
                varsDup = {};
                for (p in vars) {
                    varsDup[p] = vars[p];
                };
                varsDup.delay = curDelay;
                if ((((i == lastIndex)) && (!((onCompleteAll == null))))){
                    varsDup.onComplete = function ():void{
                        if (onCompleteProxy != null){
                            onCompleteProxy.apply(null, onCompleteParamsProxy);
                        };
                        onCompleteAll.apply(null, onCompleteAllParams);
                    };
                };
                a[i] = new TweenMax(targets[i], duration, varsDup);
                curDelay = (curDelay + stagger);
                i = (i + 1);
            };
            return (a);
        }
        public static function allFrom(_arg1:Array, _arg2:Number, _arg3:Object, _arg4:Number=0, _arg5:Function=null, _arg6:Array=null):Array{
            _arg3.runBackwards = true;
            if (!("immediateRender" in _arg3)){
                _arg3.immediateRender = true;
            };
            return (allTo(_arg1, _arg2, _arg3, _arg4, _arg5, _arg6));
        }
        public static function allFromTo(_arg1:Array, _arg2:Number, _arg3:Object, _arg4:Object, _arg5:Number=0, _arg6:Function=null, _arg7:Array=null):Array{
            _arg4.startAt = _arg3;
            if (_arg3.immediateRender){
                _arg4.immediateRender = true;
            };
            return (allTo(_arg1, _arg2, _arg4, _arg5, _arg6, _arg7));
        }
        public static function delayedCall(_arg1:Number, _arg2:Function, _arg3:Array=null, _arg4:Boolean=false):TweenMax{
            return (new TweenMax(_arg2, 0, {
                delay:_arg1,
                onComplete:_arg2,
                onCompleteParams:_arg3,
                immediateRender:false,
                useFrames:_arg4,
                overwrite:0
            }));
        }
        public static function getTweensOf(_arg1:Object):Array{
            var _local4:int;
            var _local5:int;
            var _local2:Array = masterList[_arg1];
            var _local3:Array = [];
            if (_local2){
                _local4 = _local2.length;
                _local5 = 0;
                while (--_local4 > -1) {
                    if (!TweenLite(_local2[_local4]).gc){
                        var _temp1 = _local5;
                        _local5 = (_local5 + 1);
                        var _local6 = _temp1;
                        _local3[_local6] = _local2[_local4];
                    };
                };
            };
            return (_local3);
        }
        public static function isTweening(_arg1:Object):Boolean{
            var _local4:TweenLite;
            var _local2:Array = getTweensOf(_arg1);
            var _local3:int = _local2.length;
            while (--_local3 > -1) {
                _local4 = _local2[_local3];
                if (((_local4.active) || ((((_local4.cachedStartTime == _local4.timeline.cachedTime)) && (_local4.timeline.active))))){
                    return (true);
                };
            };
            return (false);
        }
        public static function getAllTweens():Array{
            var _local4:Array;
            var _local5:int;
            var _local1:Dictionary = masterList;
            var _local2:int;
            var _local3:Array = [];
            for each (_local4 in _local1) {
                _local5 = _local4.length;
                while (--_local5 > -1) {
                    if (!TweenLite(_local4[_local5]).gc){
                        var _temp1 = _local2;
                        _local2 = (_local2 + 1);
                        var _local8 = _temp1;
                        _local3[_local8] = _local4[_local5];
                    };
                };
            };
            return (_local3);
        }
        public static function killAll(_arg1:Boolean=false, _arg2:Boolean=true, _arg3:Boolean=true):void{
            var _local5:Boolean;
            var _local4:Array = getAllTweens();
            var _local6:int = _local4.length;
            while (--_local6 > -1) {
                _local5 = (_local4[_local6].target == _local4[_local6].vars.onComplete);
                if ((((_local5 == _arg3)) || (!((_local5 == _arg2))))){
                    if (_arg1){
                        _local4[_local6].complete(false);
                    } else {
                        _local4[_local6].setEnabled(false, false);
                    };
                };
            };
        }
        public static function killChildTweensOf(_arg1:DisplayObjectContainer, _arg2:Boolean=false):void{
            var _local4:Object;
            var _local5:DisplayObjectContainer;
            var _local3:Array = getAllTweens();
            var _local6:int = _local3.length;
            while (--_local6 > -1) {
                _local4 = _local3[_local6].target;
                if ((_local4 is DisplayObject)){
                    _local5 = _local4.parent;
                    while (_local5) {
                        if (_local5 == _arg1){
                            if (_arg2){
                                _local3[_local6].complete(false);
                            } else {
                                _local3[_local6].setEnabled(false, false);
                            };
                        };
                        _local5 = _local5.parent;
                    };
                };
            };
        }
        public static function pauseAll(_arg1:Boolean=true, _arg2:Boolean=true):void{
            changePause(true, _arg1, _arg2);
        }
        public static function resumeAll(_arg1:Boolean=true, _arg2:Boolean=true):void{
            changePause(false, _arg1, _arg2);
        }
        private static function changePause(_arg1:Boolean, _arg2:Boolean=true, _arg3:Boolean=false):void{
            var _local5:Boolean;
            var _local4:Array = getAllTweens();
            var _local6:int = _local4.length;
            while (--_local6 > -1) {
                _local5 = (TweenLite(_local4[_local6]).target == TweenLite(_local4[_local6]).vars.onComplete);
                if ((((_local5 == _arg3)) || (!((_local5 == _arg2))))){
                    TweenCore(_local4[_local6]).paused = _arg1;
                };
            };
        }
        public static function get globalTimeScale():Number{
            return (((TweenLite.rootTimeline)==null) ? 1 : TweenLite.rootTimeline.cachedTimeScale);
        }
        public static function set globalTimeScale(_arg1:Number):void{
            if (_arg1 == 0){
                _arg1 = 0.0001;
            };
            if (TweenLite.rootTimeline == null){
                TweenLite.to({}, 0, {});
            };
            var _local2:SimpleTimeline = TweenLite.rootTimeline;
            var _local3:Number = (getTimer() * 0.001);
            _local2.cachedStartTime = (_local3 - (((_local3 - _local2.cachedStartTime) * _local2.cachedTimeScale) / _arg1));
            _local2 = TweenLite.rootFramesTimeline;
            _local3 = TweenLite.rootFrame;
            _local2.cachedStartTime = (_local3 - (((_local3 - _local2.cachedStartTime) * _local2.cachedTimeScale) / _arg1));
            TweenLite.rootFramesTimeline.cachedTimeScale = (TweenLite.rootTimeline.cachedTimeScale = _arg1);
        }

        override protected function init():void{
            var _local1:TweenMax;
            if (this.vars.startAt){
                this.vars.startAt.overwrite = 0;
                this.vars.startAt.immediateRender = true;
                _local1 = new TweenMax(this.target, 0, this.vars.startAt);
            };
            if (this._dispatcher){
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.INIT));
            };
            super.init();
            if ((_ease in fastEaseLookup)){
                this._easeType = fastEaseLookup[_ease][0];
                this._easePower = fastEaseLookup[_ease][1];
            };
        }
        override public function invalidate():void{
            this.yoyo = Boolean((this.vars.yoyo == true));
            this._repeat = ((this.vars.repeat) ? Number(this.vars.repeat) : 0);
            this._repeatDelay = ((this.vars.repeatDelay) ? Number(this.vars.repeatDelay) : 0);
            this._hasUpdateListener = false;
            if (((((!((this.vars.onCompleteListener == null))) || (!((this.vars.onUpdateListener == null))))) || (!((this.vars.onStartListener == null))))){
                this.initDispatcher();
            };
            setDirtyCache(true);
            super.invalidate();
        }
        public function updateTo(_arg1:Object, _arg2:Boolean=false):void{
            var _local4:String;
            var _local5:Number;
            var _local6:PropTween;
            var _local7:Number;
            var _local3:Number = this.ratio;
            if (((((_arg2) && (!((this.timeline == null))))) && ((this.cachedStartTime < this.timeline.cachedTime)))){
                this.cachedStartTime = this.timeline.cachedTime;
                this.setDirtyCache(false);
                if (this.gc){
                    this.setEnabled(true, false);
                } else {
                    this.timeline.insert(this, (this.cachedStartTime - _delay));
                };
            };
            for (_local4 in _arg1) {
                this.vars[_local4] = _arg1[_local4];
            };
            if (this.initted){
                this.initted = false;
                if (!_arg2){
                    if (((_notifyPluginsOfEnabled) && (this.cachedPT1))){
                        onPluginEvent("onDisable", this);
                    };
                    this.init();
                    if (((((!(_arg2)) && ((this.cachedTime > 0)))) && ((this.cachedTime < this.cachedDuration)))){
                        _local5 = (1 / (1 - _local3));
                        _local6 = this.cachedPT1;
                        while (_local6) {
                            _local7 = (_local6.start + _local6.change);
                            _local6.change = (_local6.change * _local5);
                            _local6.start = (_local7 - _local6.change);
                            _local6 = _local6.nextNode;
                        };
                    };
                };
            };
        }
        public function setDestination(_arg1:String, _arg2, _arg3:Boolean=true):void{
            var _local4:Object = {};
            _local4[_arg1] = _arg2;
            this.updateTo(_local4, !(_arg3));
        }
        public function killProperties(_arg1:Array):void{
            var _local2:Object = {};
            var _local3:int = _arg1.length;
            while (--_local3 > -1) {
                _local2[_arg1[_local3]] = true;
            };
            killVars(_local2);
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local6:Boolean;
            var _local7:Boolean;
            var _local8:Boolean;
            var _local10:Number;
            var _local11:int;
            var _local12:int;
            var _local13:Number;
            var _local4:Number = ((this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration);
            var _local5:Number = this.cachedTotalTime;
            if (_arg1 >= _local4){
                this.cachedTotalTime = _local4;
                this.cachedTime = this.cachedDuration;
                this.ratio = 1;
                _local6 = true;
                if (this.cachedDuration == 0){
                    if ((((((_arg1 == 0)) || ((_rawPrevTime < 0)))) && (!((_rawPrevTime == _arg1))))){
                        _arg3 = true;
                    };
                    _rawPrevTime = _arg1;
                };
            } else {
                if (_arg1 <= 0){
                    if (_arg1 < 0){
                        this.active = false;
                        if (this.cachedDuration == 0){
                            if (_rawPrevTime >= 0){
                                _arg3 = true;
                                _local6 = true;
                            };
                            _rawPrevTime = _arg1;
                        };
                    } else {
                        if ((((_arg1 == 0)) && (!(this.initted)))){
                            _arg3 = true;
                        };
                    };
                    this.cachedTotalTime = (this.cachedTime = (this.ratio = 0));
                    if (((this.cachedReversed) && (!((_local5 == 0))))){
                        _local6 = true;
                    };
                } else {
                    this.cachedTotalTime = (this.cachedTime = _arg1);
                    _local8 = true;
                };
            };
            if (this._repeat != 0){
                _local10 = (this.cachedDuration + this._repeatDelay);
                _local11 = this._cyclesComplete;
                this._cyclesComplete = ((this.cachedTotalTime / _local10) >> 0);
                if (this._cyclesComplete == (this.cachedTotalTime / _local10)){
                    this._cyclesComplete--;
                };
                if (_local11 != this._cyclesComplete){
                    _local7 = true;
                };
                if (_local6){
                    if (((this.yoyo) && ((this._repeat % 2)))){
                        this.cachedTime = (this.ratio = 0);
                    };
                } else {
                    if (_arg1 > 0){
                        this.cachedTime = (((this.cachedTotalTime / _local10) - this._cyclesComplete) * _local10);
                        if (((this.yoyo) && ((this._cyclesComplete % 2)))){
                            this.cachedTime = (this.cachedDuration - this.cachedTime);
                        } else {
                            if (this.cachedTime >= this.cachedDuration){
                                this.cachedTime = this.cachedDuration;
                                this.ratio = 1;
                                _local8 = false;
                            };
                        };
                        if (this.cachedTime <= 0){
                            this.cachedTime = (this.ratio = 0);
                            _local8 = false;
                        };
                    } else {
                        this._cyclesComplete = 0;
                    };
                };
            };
            if ((((_local5 == this.cachedTotalTime)) && (!(_arg3)))){
                return;
            };
            if (!this.initted){
                this.init();
            };
            if (((!(this.active)) && (!(this.cachedPaused)))){
                this.active = true;
            };
            if (_local8){
                if (this._easeType){
                    _local12 = this._easePower;
                    _local13 = (this.cachedTime / this.cachedDuration);
                    if (this._easeType == 2){
                        _local13 = (1 - _local13);
                        this.ratio = _local13;
                        while (--_local12 > -1) {
                            this.ratio = (_local13 * this.ratio);
                        };
                        this.ratio = (1 - this.ratio);
                    } else {
                        if (this._easeType == 1){
                            this.ratio = _local13;
                            while (--_local12 > -1) {
                                this.ratio = (_local13 * this.ratio);
                            };
                        } else {
                            if (_local13 < 0.5){
                                _local13 = (_local13 * 2);
                                this.ratio = _local13;
                                while (--_local12 > -1) {
                                    this.ratio = (_local13 * this.ratio);
                                };
                                this.ratio = (this.ratio * 0.5);
                            } else {
                                _local13 = ((1 - _local13) * 2);
                                this.ratio = _local13;
                                while (--_local12 > -1) {
                                    this.ratio = (_local13 * this.ratio);
                                };
                                this.ratio = (1 - (0.5 * this.ratio));
                            };
                        };
                    };
                } else {
                    this.ratio = _ease(this.cachedTime, 0, 1, this.cachedDuration);
                };
            };
            if ((((((_local5 == 0)) && (((!((this.cachedTotalTime == 0))) || ((this.cachedDuration == 0)))))) && (!(_arg2)))){
                if (this.vars.onStart){
                    this.vars.onStart.apply(null, this.vars.onStartParams);
                };
                if (this._dispatcher){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.START));
                };
            };
            var _local9:PropTween = this.cachedPT1;
            while (_local9) {
                _local9.target[_local9.property] = (_local9.start + (this.ratio * _local9.change));
                _local9 = _local9.nextNode;
            };
            if (((_hasUpdate) && (!(_arg2)))){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((this._hasUpdateListener) && (!(_arg2)))){
                this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.UPDATE));
            };
            if (((((_local7) && (!(_arg2)))) && (!(this.gc)))){
                if (this.vars.onRepeat){
                    this.vars.onRepeat.apply(null, this.vars.onRepeatParams);
                };
                if (this._dispatcher){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REPEAT));
                };
            };
            if (((_local6) && (!(this.gc)))){
                if (((_hasPlugins) && (this.cachedPT1))){
                    onPluginEvent("onComplete", this);
                };
                this.complete(true, _arg2);
            };
        }
        override public function complete(_arg1:Boolean=false, _arg2:Boolean=false):void{
            super.complete(_arg1, _arg2);
            if (((!(_arg2)) && (this._dispatcher))){
                if ((((this.cachedTotalTime == this.cachedTotalDuration)) && (!(this.cachedReversed)))){
                    this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.COMPLETE));
                } else {
                    if (((this.cachedReversed) && ((this.cachedTotalTime == 0)))){
                        this._dispatcher.dispatchEvent(new TweenEvent(TweenEvent.REVERSE_COMPLETE));
                    };
                };
            };
        }
        protected function initDispatcher():void{
            if (this._dispatcher == null){
                this._dispatcher = new EventDispatcher(this);
            };
            if ((this.vars.onInitListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.INIT, this.vars.onInitListener, false, 0, true);
            };
            if ((this.vars.onStartListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.START, this.vars.onStartListener, false, 0, true);
            };
            if ((this.vars.onUpdateListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.UPDATE, this.vars.onUpdateListener, false, 0, true);
                this._hasUpdateListener = true;
            };
            if ((this.vars.onCompleteListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.COMPLETE, this.vars.onCompleteListener, false, 0, true);
            };
            if ((this.vars.onRepeatListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.REPEAT, this.vars.onRepeatListener, false, 0, true);
            };
            if ((this.vars.onReverseCompleteListener is Function)){
                this._dispatcher.addEventListener(TweenEvent.REVERSE_COMPLETE, this.vars.onReverseCompleteListener, false, 0, true);
            };
        }
        public function addEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false, _arg4:int=0, _arg5:Boolean=false):void{
            if (this._dispatcher == null){
                this.initDispatcher();
            };
            if (_arg1 == TweenEvent.UPDATE){
                this._hasUpdateListener = true;
            };
            this._dispatcher.addEventListener(_arg1, _arg2, _arg3, _arg4, _arg5);
        }
        public function removeEventListener(_arg1:String, _arg2:Function, _arg3:Boolean=false):void{
            if (this._dispatcher){
                this._dispatcher.removeEventListener(_arg1, _arg2, _arg3);
            };
        }
        public function hasEventListener(_arg1:String):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.hasEventListener(_arg1));
        }
        public function willTrigger(_arg1:String):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.willTrigger(_arg1));
        }
        public function dispatchEvent(_arg1:Event):Boolean{
            return (((this._dispatcher)==null) ? false : this._dispatcher.dispatchEvent(_arg1));
        }
        public function get currentProgress():Number{
            return ((this.cachedTime / this.duration));
        }
        public function set currentProgress(_arg1:Number):void{
            if (this._cyclesComplete == 0){
                setTotalTime((this.duration * _arg1), false);
            } else {
                setTotalTime(((this.duration * _arg1) + (this._cyclesComplete * this.cachedDuration)), false);
            };
        }
        public function get totalProgress():Number{
            return ((this.cachedTotalTime / this.totalDuration));
        }
        public function set totalProgress(_arg1:Number):void{
            setTotalTime((this.totalDuration * _arg1), false);
        }
        override public function set currentTime(_arg1:Number):void{
            if (this._cyclesComplete == 0){
            } else {
                if (((this.yoyo) && (((this._cyclesComplete % 2) == 1)))){
                    _arg1 = ((this.duration - _arg1) + (this._cyclesComplete * (this.cachedDuration + this._repeatDelay)));
                } else {
                    _arg1 = (_arg1 + (this._cyclesComplete * (this.duration + this._repeatDelay)));
                };
            };
            setTotalTime(_arg1, false);
        }
        override public function get totalDuration():Number{
            if (this.cacheIsDirty){
                this.cachedTotalDuration = ((this._repeat)==-1) ? 999999999999 : ((this.cachedDuration * (this._repeat + 1)) + (this._repeatDelay * this._repeat));
                this.cacheIsDirty = false;
            };
            return (this.cachedTotalDuration);
        }
        override public function set totalDuration(_arg1:Number):void{
            if (this._repeat == -1){
                return;
            };
            this.duration = ((_arg1 - (this._repeat * this._repeatDelay)) / (this._repeat + 1));
        }
        public function get timeScale():Number{
            return (this.cachedTimeScale);
        }
        public function set timeScale(_arg1:Number):void{
            if (_arg1 == 0){
                _arg1 = 0.0001;
            };
            var _local2:Number = ((((this.cachedPauseTime) || ((this.cachedPauseTime == 0)))) ? this.cachedPauseTime : this.timeline.cachedTotalTime);
            this.cachedStartTime = (_local2 - (((_local2 - this.cachedStartTime) * this.cachedTimeScale) / _arg1));
            this.cachedTimeScale = _arg1;
            setDirtyCache(false);
        }
        public function get repeat():int{
            return (this._repeat);
        }
        public function set repeat(_arg1:int):void{
            this._repeat = _arg1;
            setDirtyCache(true);
        }
        public function get repeatDelay():Number{
            return (this._repeatDelay);
        }
        public function set repeatDelay(_arg1:Number):void{
            this._repeatDelay = _arg1;
            setDirtyCache(true);
        }

        TweenPlugin.activate([AutoAlphaPlugin, EndArrayPlugin, FramePlugin, RemoveTintPlugin, TintPlugin, VisiblePlugin, VolumePlugin, BevelFilterPlugin, BezierPlugin, BezierThroughPlugin, BlurFilterPlugin, ColorMatrixFilterPlugin, ColorTransformPlugin, DropShadowFilterPlugin, FrameLabelPlugin, GlowFilterPlugin, HexColorsPlugin, RoundPropsPlugin, ShortRotationPlugin, {}]);
    }
}//package com.greensock 
﻿package com.greensock {
    import com.greensock.core.*;

    public final class OverwriteManager {

        public static const version:Number = 6.1;
        public static const NONE:int = 0;
        public static const ALL_IMMEDIATE:int = 1;
        public static const AUTO:int = 2;
        public static const CONCURRENT:int = 3;
        public static const ALL_ONSTART:int = 4;
        public static const PREEXISTING:int = 5;

        public static var mode:int;
        public static var enabled:Boolean;

        public static function init(_arg1:int=2):int{
            if (TweenLite.version < 11.6){
                throw (new Error("Warning: Your TweenLite class needs to be updated to work with OverwriteManager (or you may need to clear your ASO files). Please download and install the latest version from http://www.tweenlite.com."));
            };
            TweenLite.overwriteManager = OverwriteManager;
            mode = _arg1;
            enabled = true;
            return (mode);
        }
        public static function manageOverwrites(_arg1:TweenLite, _arg2:Object, _arg3:Array, _arg4:int):Boolean{
            var _local5:int;
            var _local6:Boolean;
            var _local7:TweenLite;
            var _local13:int;
            var _local14:Number;
            var _local15:Number;
            var _local16:TweenCore;
            var _local17:Number;
            var _local18:SimpleTimeline;
            if (_arg4 >= 4){
                _local13 = _arg3.length;
                _local5 = 0;
                while (_local5 < _local13) {
                    _local7 = _arg3[_local5];
                    if (_local7 != _arg1){
                        if (_local7.setEnabled(false, false)){
                            _local6 = true;
                        };
                    } else {
                        if (_arg4 == 5){
                            break;
                        };
                    };
                    _local5++;
                };
                return (_local6);
            };
            var _local8:Number = (_arg1.cachedStartTime + 1E-10);
            var _local9:Array = [];
            var _local10:Array = [];
            var _local11:int;
            var _local12:int;
            _local5 = _arg3.length;
            while (--_local5 > -1) {
                _local7 = _arg3[_local5];
                if ((((((_local7 == _arg1)) || (_local7.gc))) || (((!(_local7.initted)) && (((_local8 - _local7.cachedStartTime) <= 2E-10)))))){
                } else {
                    if (_local7.timeline != _arg1.timeline){
                        if (!getGlobalPaused(_local7)){
                            var _temp1 = _local11;
                            _local11 = (_local11 + 1);
                            var _local19 = _temp1;
                            _local10[_local19] = _local7;
                        };
                    } else {
                        if ((((((((_local7.cachedStartTime <= _local8)) && ((((_local7.cachedStartTime + _local7.totalDuration) + 1E-10) > _local8)))) && (!(_local7.cachedPaused)))) && (!((((_arg1.cachedDuration == 0)) && (((_local8 - _local7.cachedStartTime) <= 2E-10))))))){
                            var _temp2 = _local12;
                            _local12 = (_local12 + 1);
                            _local19 = _temp2;
                            _local9[_local19] = _local7;
                        };
                    };
                };
            };
            if (_local11 != 0){
                _local14 = _arg1.cachedTimeScale;
                _local15 = _local8;
                _local18 = _arg1.timeline;
                while (_local18) {
                    _local14 = (_local14 * _local18.cachedTimeScale);
                    _local15 = (_local15 + _local18.cachedStartTime);
                    _local18 = _local18.timeline;
                };
                _local8 = (_local14 * _local15);
                _local5 = _local11;
                while (--_local5 > -1) {
                    _local16 = _local10[_local5];
                    _local14 = _local16.cachedTimeScale;
                    _local15 = _local16.cachedStartTime;
                    _local18 = _local16.timeline;
                    while (_local18) {
                        _local14 = (_local14 * _local18.cachedTimeScale);
                        _local15 = (_local15 + _local18.cachedStartTime);
                        _local18 = _local18.timeline;
                    };
                    _local17 = (_local14 * _local15);
                    if ((((_local17 <= _local8)) && ((((((_local17 + (_local16.totalDuration * _local14)) + 1E-10) > _local8)) || ((_local16.cachedDuration == 0)))))){
                        var _temp3 = _local12;
                        _local12 = (_local12 + 1);
                        _local19 = _temp3;
                        _local9[_local19] = _local16;
                    };
                };
            };
            if (_local12 == 0){
                return (_local6);
            };
            _local5 = _local12;
            if (_arg4 == 2){
                while (--_local5 > -1) {
                    _local7 = _local9[_local5];
                    if (_local7.killVars(_arg2)){
                        _local6 = true;
                    };
                    if ((((_local7.cachedPT1 == null)) && (_local7.initted))){
                        _local7.setEnabled(false, false);
                    };
                };
            } else {
                while (--_local5 > -1) {
                    if (TweenLite(_local9[_local5]).setEnabled(false, false)){
                        _local6 = true;
                    };
                };
            };
            return (_local6);
        }
        public static function getGlobalPaused(_arg1:TweenCore):Boolean{
            var _local2:Boolean;
            while (_arg1) {
                if (_arg1.cachedPaused){
                    _local2 = true;
                    break;
                };
                _arg1 = _arg1.timeline;
            };
            return (_local2);
        }

    }
}//package com.greensock 
﻿package com.greensock {
    import flash.display.*;
    import flash.events.*;
    import com.greensock.core.*;
    import com.greensock.plugins.*;
    import flash.utils.*;

    public class TweenLite extends TweenCore {

        public static const version:Number = 11.62;

        public static var plugins:Object = {};
        public static var fastEaseLookup:Dictionary = new Dictionary(false);
        public static var onPluginEvent:Function;
        public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
        public static var defaultEase:Function = TweenLite.easeOut;
        public static var overwriteManager:Object;
        public static var rootFrame:Number;
        public static var rootTimeline:SimpleTimeline;
        public static var rootFramesTimeline:SimpleTimeline;
        public static var masterList:Dictionary = new Dictionary(false);
        private static var _shape:Shape = new Shape();
        protected static var _reservedProps:Object = {
            ease:1,
            delay:1,
            overwrite:1,
            onComplete:1,
            onCompleteParams:1,
            useFrames:1,
            runBackwards:1,
            startAt:1,
            onUpdate:1,
            onUpdateParams:1,
            onStart:1,
            onStartParams:1,
            onInit:1,
            onInitParams:1,
            onReverseComplete:1,
            onReverseCompleteParams:1,
            onRepeat:1,
            onRepeatParams:1,
            proxiedEase:1,
            easeParams:1,
            yoyo:1,
            onCompleteListener:1,
            onUpdateListener:1,
            onStartListener:1,
            onReverseCompleteListener:1,
            onRepeatListener:1,
            orientToBezier:1,
            timeScale:1,
            immediateRender:1,
            repeat:1,
            repeatDelay:1,
            timeline:1,
            data:1,
            paused:1
        };

        public var target:Object;
        public var propTweenLookup:Object;
        public var ratio:Number = 0;
        public var cachedPT1:PropTween;
        protected var _ease:Function;
        protected var _overwrite:int;
        protected var _overwrittenProps:Object;
        protected var _hasPlugins:Boolean;
        protected var _notifyPluginsOfEnabled:Boolean;

        public function TweenLite(_arg1:Object, _arg2:Number, _arg3:Object){
            var _local5:TweenLite;
            super(_arg2, _arg3);
            if (_arg1 == null){
                throw (new Error("Cannot tween a null object."));
            };
            this.target = _arg1;
            if ((((this.target is TweenCore)) && (this.vars.timeScale))){
                this.cachedTimeScale = 1;
            };
            this.propTweenLookup = {};
            this._ease = defaultEase;
            this._overwrite = ((((!((Number(_arg3.overwrite) > -1))) || (((!(overwriteManager.enabled)) && ((_arg3.overwrite > 1)))))) ? overwriteManager.mode : int(_arg3.overwrite));
            var _local4:Array = masterList[_arg1];
            if (!_local4){
                masterList[_arg1] = [this];
            } else {
                if (this._overwrite == 1){
                    for each (_local5 in _local4) {
                        if (!_local5.gc){
                            _local5.setEnabled(false, false);
                        };
                    };
                    masterList[_arg1] = [this];
                } else {
                    _local4[_local4.length] = this;
                };
            };
            if (((this.active) || (this.vars.immediateRender))){
                this.renderTime(0, false, true);
            };
        }
        public static function initClass():void{
            rootFrame = 0;
            rootTimeline = new SimpleTimeline(null);
            rootFramesTimeline = new SimpleTimeline(null);
            rootTimeline.cachedStartTime = (getTimer() * 0.001);
            rootFramesTimeline.cachedStartTime = rootFrame;
            rootTimeline.autoRemoveChildren = true;
            rootFramesTimeline.autoRemoveChildren = true;
            _shape.addEventListener(Event.ENTER_FRAME, updateAll, false, 0, true);
            if (overwriteManager == null){
                overwriteManager = {
                    mode:1,
                    enabled:false
                };
            };
        }
        public static function to(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            return (new TweenLite(_arg1, _arg2, _arg3));
        }
        public static function from(_arg1:Object, _arg2:Number, _arg3:Object):TweenLite{
            _arg3.runBackwards = true;
            if (!("immediateRender" in _arg3)){
                _arg3.immediateRender = true;
            };
            return (new TweenLite(_arg1, _arg2, _arg3));
        }
        public static function delayedCall(_arg1:Number, _arg2:Function, _arg3:Array=null, _arg4:Boolean=false):TweenLite{
            return (new TweenLite(_arg2, 0, {
                delay:_arg1,
                onComplete:_arg2,
                onCompleteParams:_arg3,
                immediateRender:false,
                useFrames:_arg4,
                overwrite:0
            }));
        }
        protected static function updateAll(_arg1:Event=null):void{
            var _local2:Dictionary;
            var _local3:Object;
            var _local4:Array;
            var _local5:int;
            rootTimeline.renderTime((((getTimer() * 0.001) - rootTimeline.cachedStartTime) * rootTimeline.cachedTimeScale), false, false);
            rootFrame = (rootFrame + 1);
            rootFramesTimeline.renderTime(((rootFrame - rootFramesTimeline.cachedStartTime) * rootFramesTimeline.cachedTimeScale), false, false);
            if (!(rootFrame % 60)){
                _local2 = masterList;
                for (_local3 in _local2) {
                    _local4 = _local2[_local3];
                    _local5 = _local4.length;
                    while (--_local5 > -1) {
                        if (TweenLite(_local4[_local5]).gc){
                            _local4.splice(_local5, 1);
                        };
                    };
                    if (_local4.length == 0){
                        delete _local2[_local3];
                    };
                };
            };
        }
        public static function killTweensOf(_arg1:Object, _arg2:Boolean=false, _arg3:Object=null):void{
            var _local4:Array;
            var _local5:int;
            var _local6:TweenLite;
            if ((_arg1 in masterList)){
                _local4 = masterList[_arg1];
                _local5 = _local4.length;
                while (--_local5 > -1) {
                    _local6 = _local4[_local5];
                    if (!_local6.gc){
                        if (_arg2){
                            _local6.complete(false, false);
                        };
                        if (_arg3 != null){
                            _local6.killVars(_arg3);
                        };
                        if ((((_arg3 == null)) || ((((_local6.cachedPT1 == null)) && (_local6.initted))))){
                            _local6.setEnabled(false, false);
                        };
                    };
                };
                if (_arg3 == null){
                    delete masterList[_arg1];
                };
            };
        }
        protected static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (1 - (_arg1 / _arg4));
            return ((1 - (_arg1 * _arg1)));
        }

        protected function init():void{
            var _local1:String;
            var _local2:int;
            var _local3:*;
            var _local4:Boolean;
            var _local5:Array;
            var _local6:PropTween;
            if (this.vars.onInit){
                this.vars.onInit.apply(null, this.vars.onInitParams);
            };
            if (typeof(this.vars.ease) == "function"){
                this._ease = this.vars.ease;
            };
            if (this.vars.easeParams){
                this.vars.proxiedEase = this._ease;
                this._ease = this.easeProxy;
            };
            this.cachedPT1 = null;
            this.propTweenLookup = {};
            for (_local1 in this.vars) {
                if ((((_local1 in _reservedProps)) && (!((((_local1 == "timeScale")) && ((this.target is TweenCore))))))){
                } else {
                    if ((((_local1 in plugins)) && ((_local3 = new ((plugins[_local1] as Class))()).onInitTween(this.target, this.vars[_local1], this)))){
                        this.cachedPT1 = new PropTween(_local3, "changeFactor", 0, 1, ((_local3.overwriteProps.length)==1) ? _local3.overwriteProps[0] : "_MULTIPLE_", true, this.cachedPT1);
                        if (this.cachedPT1.name == "_MULTIPLE_"){
                            _local2 = _local3.overwriteProps.length;
                            while (--_local2 > -1) {
                                this.propTweenLookup[_local3.overwriteProps[_local2]] = this.cachedPT1;
                            };
                        } else {
                            this.propTweenLookup[this.cachedPT1.name] = this.cachedPT1;
                        };
                        if (_local3.priority){
                            this.cachedPT1.priority = _local3.priority;
                            _local4 = true;
                        };
                        if (((_local3.onDisable) || (_local3.onEnable))){
                            this._notifyPluginsOfEnabled = true;
                        };
                        this._hasPlugins = true;
                    } else {
                        this.cachedPT1 = new PropTween(this.target, _local1, Number(this.target[_local1]), ((typeof(this.vars[_local1]))=="number") ? (Number(this.vars[_local1]) - this.target[_local1]) : Number(this.vars[_local1]), _local1, false, this.cachedPT1);
                        this.propTweenLookup[_local1] = this.cachedPT1;
                    };
                };
            };
            if (_local4){
                onPluginEvent("onInitAllProps", this);
            };
            if (this.vars.runBackwards){
                _local6 = this.cachedPT1;
                while (_local6) {
                    _local6.start = (_local6.start + _local6.change);
                    _local6.change = -(_local6.change);
                    _local6 = _local6.nextNode;
                };
            };
            _hasUpdate = Boolean(!((this.vars.onUpdate == null)));
            if (this._overwrittenProps){
                this.killVars(this._overwrittenProps);
                if (this.cachedPT1 == null){
                    this.setEnabled(false, false);
                };
            };
            if ((((((((this._overwrite > 1)) && (this.cachedPT1))) && ((_local5 = masterList[this.target])))) && ((_local5.length > 1)))){
                if (overwriteManager.manageOverwrites(this, this.propTweenLookup, _local5, this._overwrite)){
                    this.init();
                };
            };
            this.initted = true;
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local4:Boolean;
            var _local5:Number = this.cachedTime;
            if (_arg1 >= this.cachedDuration){
                this.cachedTotalTime = (this.cachedTime = this.cachedDuration);
                this.ratio = 1;
                _local4 = true;
                if (this.cachedDuration == 0){
                    if ((((((_arg1 == 0)) || ((_rawPrevTime < 0)))) && (!((_rawPrevTime == _arg1))))){
                        _arg3 = true;
                    };
                    _rawPrevTime = _arg1;
                };
            } else {
                if (_arg1 <= 0){
                    this.cachedTotalTime = (this.cachedTime = (this.ratio = 0));
                    if (_arg1 < 0){
                        this.active = false;
                        if (this.cachedDuration == 0){
                            if (_rawPrevTime >= 0){
                                _arg3 = true;
                                _local4 = true;
                            };
                            _rawPrevTime = _arg1;
                        };
                    };
                    if (((this.cachedReversed) && (!((_local5 == 0))))){
                        _local4 = true;
                    };
                } else {
                    this.cachedTotalTime = (this.cachedTime = _arg1);
                    this.ratio = this._ease(_arg1, 0, 1, this.cachedDuration);
                };
            };
            if ((((this.cachedTime == _local5)) && (!(_arg3)))){
                return;
            };
            if (!this.initted){
                this.init();
                if (((!(_local4)) && (this.cachedTime))){
                    this.ratio = this._ease(this.cachedTime, 0, 1, this.cachedDuration);
                };
            };
            if (((!(this.active)) && (!(this.cachedPaused)))){
                this.active = true;
            };
            if ((((((((_local5 == 0)) && (this.vars.onStart))) && (((!((this.cachedTime == 0))) || ((this.cachedDuration == 0)))))) && (!(_arg2)))){
                this.vars.onStart.apply(null, this.vars.onStartParams);
            };
            var _local6:PropTween = this.cachedPT1;
            while (_local6) {
                _local6.target[_local6.property] = (_local6.start + (this.ratio * _local6.change));
                _local6 = _local6.nextNode;
            };
            if (((_hasUpdate) && (!(_arg2)))){
                this.vars.onUpdate.apply(null, this.vars.onUpdateParams);
            };
            if (((_local4) && (!(this.gc)))){
                if (((this._hasPlugins) && (this.cachedPT1))){
                    onPluginEvent("onComplete", this);
                };
                complete(true, _arg2);
            };
        }
        public function killVars(_arg1:Object, _arg2:Boolean=true):Boolean{
            var _local3:String;
            var _local4:PropTween;
            var _local5:Boolean;
            if (this._overwrittenProps == null){
                this._overwrittenProps = {};
            };
            for (_local3 in _arg1) {
                if ((_local3 in this.propTweenLookup)){
                    _local4 = this.propTweenLookup[_local3];
                    if (((_local4.isPlugin) && ((_local4.name == "_MULTIPLE_")))){
                        _local4.target.killProps(_arg1);
                        if (_local4.target.overwriteProps.length == 0){
                            _local4.name = "";
                        };
                        if (((!((_local3 == _local4.target.propName))) || ((_local4.name == "")))){
                            delete this.propTweenLookup[_local3];
                        };
                    };
                    if (_local4.name != "_MULTIPLE_"){
                        if (_local4.nextNode){
                            _local4.nextNode.prevNode = _local4.prevNode;
                        };
                        if (_local4.prevNode){
                            _local4.prevNode.nextNode = _local4.nextNode;
                        } else {
                            if (this.cachedPT1 == _local4){
                                this.cachedPT1 = _local4.nextNode;
                            };
                        };
                        if (((_local4.isPlugin) && (_local4.target.onDisable))){
                            _local4.target.onDisable();
                            if (_local4.target.activeDisable){
                                _local5 = true;
                            };
                        };
                        delete this.propTweenLookup[_local3];
                    };
                };
                if (((_arg2) && (!((_arg1 == this._overwrittenProps))))){
                    this._overwrittenProps[_local3] = 1;
                };
            };
            return (_local5);
        }
        override public function invalidate():void{
            if (((this._notifyPluginsOfEnabled) && (this.cachedPT1))){
                onPluginEvent("onDisable", this);
            };
            this.cachedPT1 = null;
            this._overwrittenProps = null;
            _hasUpdate = (this.initted = (this.active = (this._notifyPluginsOfEnabled = false)));
            this.propTweenLookup = {};
        }
        override public function setEnabled(_arg1:Boolean, _arg2:Boolean=false):Boolean{
            var _local3:Array;
            if (_arg1){
                _local3 = TweenLite.masterList[this.target];
                if (!_local3){
                    TweenLite.masterList[this.target] = [this];
                } else {
                    _local3[_local3.length] = this;
                };
            };
            super.setEnabled(_arg1, _arg2);
            if (((this._notifyPluginsOfEnabled) && (this.cachedPT1))){
                return (onPluginEvent(((_arg1) ? "onEnable" : "onDisable"), this));
            };
            return (false);
        }
        protected function easeProxy(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            return (this.vars.proxiedEase.apply(null, arguments.concat(this.vars.easeParams)));
        }

    }
}//package com.greensock 
﻿package com.greensock.easing {

    public class Cubic {

        public static const power:uint = 2;

        public static function easeIn(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / _arg4);
            return (((((_arg3 * _arg1) * _arg1) * _arg1) + _arg2));
        }
        public static function easeOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = ((_arg1 / _arg4) - 1);
            return (((_arg3 * (((_arg1 * _arg1) * _arg1) + 1)) + _arg2));
        }
        public static function easeInOut(_arg1:Number, _arg2:Number, _arg3:Number, _arg4:Number):Number{
            _arg1 = (_arg1 / (_arg4 * 0.5));
            if (_arg1 < 1){
                return ((((((_arg3 * 0.5) * _arg1) * _arg1) * _arg1) + _arg2));
            };
            _arg1 = (_arg1 - 2);
            return ((((_arg3 * 0.5) * (((_arg1 * _arg1) * _arg1) + 2)) + _arg2));
        }

    }
}//package com.greensock.easing 
﻿package com.greensock.core {
    import com.greensock.*;

    public class TweenCore {

        public static const version:Number = 1.64;

        protected static var _classInitted:Boolean;

        protected var _delay:Number;
        protected var _hasUpdate:Boolean;
        protected var _rawPrevTime:Number = -1;
        public var vars:Object;
        public var active:Boolean;
        public var gc:Boolean;
        public var initted:Boolean;
        public var timeline:SimpleTimeline;
        public var cachedStartTime:Number;
        public var cachedTime:Number;
        public var cachedTotalTime:Number;
        public var cachedDuration:Number;
        public var cachedTotalDuration:Number;
        public var cachedTimeScale:Number;
        public var cachedPauseTime:Number;
        public var cachedReversed:Boolean;
        public var nextNode:TweenCore;
        public var prevNode:TweenCore;
        public var cachedOrphan:Boolean;
        public var cacheIsDirty:Boolean;
        public var cachedPaused:Boolean;
        public var data;

        public function TweenCore(_arg1:Number=0, _arg2:Object=null){
            this.vars = ((_arg2)!=null) ? _arg2 : {};
            if (this.vars.isGSVars){
                this.vars = this.vars.vars;
            };
            this.cachedDuration = (this.cachedTotalDuration = _arg1);
            this._delay = ((this.vars.delay) ? Number(this.vars.delay) : 0);
            this.cachedTimeScale = ((this.vars.timeScale) ? Number(this.vars.timeScale) : 1);
            this.active = Boolean((((((_arg1 == 0)) && ((this._delay == 0)))) && (!((this.vars.immediateRender == false)))));
            this.cachedTotalTime = (this.cachedTime = 0);
            this.data = this.vars.data;
            if (!_classInitted){
                if (isNaN(TweenLite.rootFrame)){
                    TweenLite.initClass();
                    _classInitted = true;
                } else {
                    return;
                };
            };
            var _local3:SimpleTimeline = (((this.vars.timeline is SimpleTimeline)) ? this.vars.timeline : ((this.vars.useFrames) ? TweenLite.rootFramesTimeline : TweenLite.rootTimeline));
            _local3.insert(this, _local3.cachedTotalTime);
            if (this.vars.reversed){
                this.cachedReversed = true;
            };
            if (this.vars.paused){
                this.paused = true;
            };
        }
        public function play():void{
            this.reversed = false;
            this.paused = false;
        }
        public function pause():void{
            this.paused = true;
        }
        public function resume():void{
            this.paused = false;
        }
        public function restart(_arg1:Boolean=false, _arg2:Boolean=true):void{
            this.reversed = false;
            this.paused = false;
            this.setTotalTime(((_arg1) ? -(this._delay) : 0), _arg2);
        }
        public function reverse(_arg1:Boolean=true):void{
            this.reversed = true;
            if (_arg1){
                this.paused = false;
            } else {
                if (this.gc){
                    this.setEnabled(true, false);
                };
            };
        }
        public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
        }
        public function complete(_arg1:Boolean=false, _arg2:Boolean=false):void{
            if (!_arg1){
                this.renderTime(this.totalDuration, _arg2, false);
                return;
            };
            if (this.timeline.autoRemoveChildren){
                this.setEnabled(false, false);
            } else {
                this.active = false;
            };
            if (!_arg2){
                if (((((this.vars.onComplete) && ((this.cachedTotalTime >= this.cachedTotalDuration)))) && (!(this.cachedReversed)))){
                    this.vars.onComplete.apply(null, this.vars.onCompleteParams);
                } else {
                    if (((((this.cachedReversed) && ((this.cachedTotalTime == 0)))) && (this.vars.onReverseComplete))){
                        this.vars.onReverseComplete.apply(null, this.vars.onReverseCompleteParams);
                    };
                };
            };
        }
        public function invalidate():void{
        }
        public function setEnabled(_arg1:Boolean, _arg2:Boolean=false):Boolean{
            this.gc = !(_arg1);
            if (_arg1){
                this.active = Boolean(((((!(this.cachedPaused)) && ((this.cachedTotalTime > 0)))) && ((this.cachedTotalTime < this.cachedTotalDuration))));
                if (((!(_arg2)) && (this.cachedOrphan))){
                    this.timeline.insert(this, (this.cachedStartTime - this._delay));
                };
            } else {
                this.active = false;
                if (((!(_arg2)) && (!(this.cachedOrphan)))){
                    this.timeline.remove(this, true);
                };
            };
            return (false);
        }
        public function kill():void{
            this.setEnabled(false, false);
        }
        protected function setDirtyCache(_arg1:Boolean=true):void{
            var _local2:TweenCore = ((_arg1) ? this : this.timeline);
            while (_local2) {
                _local2.cacheIsDirty = true;
                _local2 = _local2.timeline;
            };
        }
        protected function setTotalTime(_arg1:Number, _arg2:Boolean=false):void{
            var _local3:Number;
            var _local4:Number;
            if (this.timeline){
                _local3 = ((this.cachedPaused) ? this.cachedPauseTime : this.timeline.cachedTotalTime);
                if (this.cachedReversed){
                    _local4 = ((this.cacheIsDirty) ? this.totalDuration : this.cachedTotalDuration);
                    this.cachedStartTime = (_local3 - ((_local4 - _arg1) / this.cachedTimeScale));
                } else {
                    this.cachedStartTime = (_local3 - (_arg1 / this.cachedTimeScale));
                };
                if (!this.timeline.cacheIsDirty){
                    this.setDirtyCache(false);
                };
                if (this.cachedTotalTime != _arg1){
                    this.renderTime(_arg1, _arg2, false);
                };
            };
        }
        public function get delay():Number{
            return (this._delay);
        }
        public function set delay(_arg1:Number):void{
            this.startTime = (this.startTime + (_arg1 - this._delay));
            this._delay = _arg1;
        }
        public function get duration():Number{
            return (this.cachedDuration);
        }
        public function set duration(_arg1:Number):void{
            var _local2:Number = (_arg1 / this.cachedDuration);
            this.cachedDuration = (this.cachedTotalDuration = _arg1);
            if (((((this.active) && (!(this.cachedPaused)))) && (!((_arg1 == 0))))){
                this.setTotalTime((this.cachedTotalTime * _local2), true);
            };
            this.setDirtyCache(false);
        }
        public function get totalDuration():Number{
            return (this.cachedTotalDuration);
        }
        public function set totalDuration(_arg1:Number):void{
            this.duration = _arg1;
        }
        public function get currentTime():Number{
            return (this.cachedTime);
        }
        public function set currentTime(_arg1:Number):void{
            this.setTotalTime(_arg1, false);
        }
        public function get totalTime():Number{
            return (this.cachedTotalTime);
        }
        public function set totalTime(_arg1:Number):void{
            this.setTotalTime(_arg1, false);
        }
        public function get startTime():Number{
            return (this.cachedStartTime);
        }
        public function set startTime(_arg1:Number):void{
            if (((!((this.timeline == null))) && (((!((_arg1 == this.cachedStartTime))) || (this.gc))))){
                this.timeline.insert(this, (_arg1 - this._delay));
            } else {
                this.cachedStartTime = _arg1;
            };
        }
        public function get reversed():Boolean{
            return (this.cachedReversed);
        }
        public function set reversed(_arg1:Boolean):void{
            if (_arg1 != this.cachedReversed){
                this.cachedReversed = _arg1;
                this.setTotalTime(this.cachedTotalTime, true);
            };
        }
        public function get paused():Boolean{
            return (this.cachedPaused);
        }
        public function set paused(_arg1:Boolean):void{
            if (((!((_arg1 == this.cachedPaused))) && (this.timeline))){
                if (_arg1){
                    this.cachedPauseTime = this.timeline.rawTime;
                } else {
                    this.cachedStartTime = (this.cachedStartTime + (this.timeline.rawTime - this.cachedPauseTime));
                    this.cachedPauseTime = NaN;
                    this.setDirtyCache(false);
                };
                this.cachedPaused = _arg1;
                this.active = Boolean(((((!(this.cachedPaused)) && ((this.cachedTotalTime > 0)))) && ((this.cachedTotalTime < this.cachedTotalDuration))));
            };
            if (((!(_arg1)) && (this.gc))){
                this.setTotalTime(this.cachedTotalTime, false);
                this.setEnabled(true, false);
            };
        }

    }
}//package com.greensock.core 
﻿package com.greensock.core {

    public class SimpleTimeline extends TweenCore {

        protected var _firstChild:TweenCore;
        protected var _lastChild:TweenCore;
        public var autoRemoveChildren:Boolean;

        public function SimpleTimeline(_arg1:Object=null){
            super(0, _arg1);
        }
        public function insert(_arg1:TweenCore, _arg2=0):TweenCore{
            if (((!(_arg1.cachedOrphan)) && (_arg1.timeline))){
                _arg1.timeline.remove(_arg1, true);
            };
            _arg1.timeline = this;
            _arg1.cachedStartTime = (Number(_arg2) + _arg1.delay);
            if (_arg1.gc){
                _arg1.setEnabled(true, true);
            };
            if (_arg1.cachedPaused){
                _arg1.cachedPauseTime = (_arg1.cachedStartTime + ((this.rawTime - _arg1.cachedStartTime) / _arg1.cachedTimeScale));
            };
            if (this._lastChild){
                this._lastChild.nextNode = _arg1;
            } else {
                this._firstChild = _arg1;
            };
            _arg1.prevNode = this._lastChild;
            this._lastChild = _arg1;
            _arg1.nextNode = null;
            _arg1.cachedOrphan = false;
            return (_arg1);
        }
        public function remove(_arg1:TweenCore, _arg2:Boolean=false):void{
            if (_arg1.cachedOrphan){
                return;
            };
            if (!_arg2){
                _arg1.setEnabled(false, true);
            };
            if (_arg1.nextNode){
                _arg1.nextNode.prevNode = _arg1.prevNode;
            } else {
                if (this._lastChild == _arg1){
                    this._lastChild = _arg1.prevNode;
                };
            };
            if (_arg1.prevNode){
                _arg1.prevNode.nextNode = _arg1.nextNode;
            } else {
                if (this._firstChild == _arg1){
                    this._firstChild = _arg1.nextNode;
                };
            };
            _arg1.cachedOrphan = true;
        }
        override public function renderTime(_arg1:Number, _arg2:Boolean=false, _arg3:Boolean=false):void{
            var _local5:Number;
            var _local6:TweenCore;
            var _local4:TweenCore = this._firstChild;
            this.cachedTotalTime = _arg1;
            this.cachedTime = _arg1;
            while (_local4) {
                _local6 = _local4.nextNode;
                if (((_local4.active) || ((((((_arg1 >= _local4.cachedStartTime)) && (!(_local4.cachedPaused)))) && (!(_local4.gc)))))){
                    if (!_local4.cachedReversed){
                        _local4.renderTime(((_arg1 - _local4.cachedStartTime) * _local4.cachedTimeScale), _arg2, false);
                    } else {
                        _local5 = ((_local4.cacheIsDirty) ? _local4.totalDuration : _local4.cachedTotalDuration);
                        _local4.renderTime((_local5 - ((_arg1 - _local4.cachedStartTime) * _local4.cachedTimeScale)), _arg2, false);
                    };
                };
                _local4 = _local6;
            };
        }
        public function get rawTime():Number{
            return (this.cachedTotalTime);
        }

    }
}//package com.greensock.core 
﻿package com.greensock.core {

    public final class PropTween {

        public var target:Object;
        public var property:String;
        public var start:Number;
        public var change:Number;
        public var name:String;
        public var priority:int;
        public var isPlugin:Boolean;
        public var nextNode:PropTween;
        public var prevNode:PropTween;

        public function PropTween(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number, _arg5:String, _arg6:Boolean, _arg7:PropTween=null, _arg8:int=0){
            this.target = _arg1;
            this.property = _arg2;
            this.start = _arg3;
            this.change = _arg4;
            this.name = _arg5;
            this.isPlugin = _arg6;
            if (_arg7){
                _arg7.prevNode = this;
                this.nextNode = _arg7;
            };
            this.priority = _arg8;
        }
    }
}//package com.greensock.core 
﻿package com.greensock.events {
    import flash.events.*;

    public class TweenEvent extends Event {

        public static const VERSION:Number = 1.1;
        public static const START:String = "start";
        public static const UPDATE:String = "change";
        public static const COMPLETE:String = "complete";
        public static const REVERSE_COMPLETE:String = "reverseComplete";
        public static const REPEAT:String = "repeat";
        public static const INIT:String = "init";

        public function TweenEvent(_arg1:String, _arg2:Boolean=false, _arg3:Boolean=false){
            super(_arg1, _arg2, _arg3);
        }
        override public function clone():Event{
            return (new TweenEvent(this.type, this.bubbles, this.cancelable));
        }

    }
}//package com.greensock.events 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class BezierPlugin extends TweenPlugin {

        public static const API:Number = 1;
        protected static const _RAD2DEG:Number = 57.2957795130823;

        protected var _target:Object;
        protected var _orientData:Array;
        protected var _orient:Boolean;
        protected var _future:Object;
        protected var _beziers:Object;

        public function BezierPlugin(){
            this._future = {};
            super();
            this.propName = "bezier";
            this.overwriteProps = [];
        }
        public static function parseBeziers(_arg1:Object, _arg2:Boolean=false):Object{
            var _local3:int;
            var _local4:Array;
            var _local5:Object;
            var _local6:String;
            var _local7:Object = {};
            if (_arg2){
                for (_local6 in _arg1) {
                    _local4 = _arg1[_local6];
                    _local5 = [];
                    _local7[_local6] = _local5;
                    if (_local4.length > 2){
                        _local5[_local5.length] = [_local4[0], (_local4[1] - ((_local4[2] - _local4[0]) / 4)), _local4[1]];
                        _local3 = 1;
                        while (_local3 < (_local4.length - 1)) {
                            _local5[_local5.length] = [_local4[_local3], (_local4[_local3] + (_local4[_local3] - _local5[(_local3 - 1)][1])), _local4[(_local3 + 1)]];
                            _local3 = (_local3 + 1);
                        };
                    } else {
                        _local5[_local5.length] = [_local4[0], ((_local4[0] + _local4[1]) / 2), _local4[1]];
                    };
                };
            } else {
                for (_local6 in _arg1) {
                    _local4 = _arg1[_local6];
                    _local5 = [];
                    _local7[_local6] = _local5;
                    if (_local4.length > 3){
                        _local5[_local5.length] = [_local4[0], _local4[1], ((_local4[1] + _local4[2]) / 2)];
                        _local3 = 2;
                        while (_local3 < (_local4.length - 2)) {
                            _local5[_local5.length] = [_local5[(_local3 - 2)][2], _local4[_local3], ((_local4[_local3] + _local4[(_local3 + 1)]) / 2)];
                            _local3 = (_local3 + 1);
                        };
                        _local5[_local5.length] = [_local5[(_local5.length - 1)][2], _local4[(_local4.length - 2)], _local4[(_local4.length - 1)]];
                    } else {
                        if (_local4.length == 3){
                            _local5[_local5.length] = [_local4[0], _local4[1], _local4[2]];
                        } else {
                            if (_local4.length == 2){
                                _local5[_local5.length] = [_local4[0], ((_local4[0] + _local4[1]) / 2), _local4[1]];
                            };
                        };
                    };
                };
            };
            return (_local7);
        }

        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg2 is Array)){
                return (false);
            };
            this.init(_arg3, (_arg2 as Array), false);
            return (true);
        }
        protected function init(_arg1:TweenLite, _arg2:Array, _arg3:Boolean):void{
            var _local6:int;
            var _local7:String;
            var _local8:Object;
            this._target = _arg1.target;
            var _local4:Object = ((_arg1.vars.isTV)==true) ? _arg1.vars.exposedVars : _arg1.vars;
            if (_local4.orientToBezier == true){
                this._orientData = [["x", "y", "rotation", 0, 0.01]];
                this._orient = true;
            } else {
                if ((_local4.orientToBezier is Array)){
                    this._orientData = _local4.orientToBezier;
                    this._orient = true;
                };
            };
            var _local5:Object = {};
            _local6 = 0;
            while (_local6 < _arg2.length) {
                for (_local7 in _arg2[_local6]) {
                    if (_local5[_local7] == undefined){
                        _local5[_local7] = [_arg1.target[_local7]];
                    };
                    if (typeof(_arg2[_local6][_local7]) == "number"){
                        _local5[_local7].push(_arg2[_local6][_local7]);
                    } else {
                        _local5[_local7].push((_arg1.target[_local7] + Number(_arg2[_local6][_local7])));
                    };
                };
                _local6 = (_local6 + 1);
            };
            for (_local7 in _local5) {
                this.overwriteProps[this.overwriteProps.length] = _local7;
                if (_local4[_local7] != undefined){
                    if (typeof(_local4[_local7]) == "number"){
                        _local5[_local7].push(_local4[_local7]);
                    } else {
                        _local5[_local7].push((_arg1.target[_local7] + Number(_local4[_local7])));
                    };
                    _local8 = {};
                    _local8[_local7] = true;
                    _arg1.killVars(_local8, false);
                    delete _local4[_local7];
                };
            };
            this._beziers = parseBeziers(_local5, _arg3);
        }
        override public function killProps(_arg1:Object):void{
            var _local2:String;
            for (_local2 in this._beziers) {
                if ((_local2 in _arg1)){
                    delete this._beziers[_local2];
                };
            };
            super.killProps(_arg1);
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:int;
            var _local3:String;
            var _local4:Object;
            var _local5:Number;
            var _local6:int;
            var _local7:Number;
            var _local8:Object;
            var _local9:Number;
            var _local10:Number;
            var _local11:Array;
            var _local12:Number;
            var _local13:Object;
            var _local14:Boolean;
            _changeFactor = _arg1;
            if (_arg1 == 1){
                for (_local3 in this._beziers) {
                    _local2 = (this._beziers[_local3].length - 1);
                    this._target[_local3] = this._beziers[_local3][_local2][2];
                };
            } else {
                for (_local3 in this._beziers) {
                    _local6 = this._beziers[_local3].length;
                    if (_arg1 < 0){
                        _local2 = 0;
                    } else {
                        if (_arg1 >= 1){
                            _local2 = (_local6 - 1);
                        } else {
                            _local2 = ((_local6 * _arg1) >> 0);
                        };
                    };
                    _local5 = ((_arg1 - (_local2 * (1 / _local6))) * _local6);
                    _local4 = this._beziers[_local3][_local2];
                    if (this.round){
                        _local7 = (_local4[0] + (_local5 * (((2 * (1 - _local5)) * (_local4[1] - _local4[0])) + (_local5 * (_local4[2] - _local4[0])))));
                        if (_local7 > 0){
                            this._target[_local3] = ((_local7 + 0.5) >> 0);
                        } else {
                            this._target[_local3] = ((_local7 - 0.5) >> 0);
                        };
                    } else {
                        this._target[_local3] = (_local4[0] + (_local5 * (((2 * (1 - _local5)) * (_local4[1] - _local4[0])) + (_local5 * (_local4[2] - _local4[0])))));
                    };
                };
            };
            if (this._orient){
                _local2 = this._orientData.length;
                _local8 = {};
                while (_local2--) {
                    _local11 = this._orientData[_local2];
                    _local8[_local11[0]] = this._target[_local11[0]];
                    _local8[_local11[1]] = this._target[_local11[1]];
                };
                _local13 = this._target;
                _local14 = this.round;
                this._target = this._future;
                this.round = false;
                this._orient = false;
                _local2 = this._orientData.length;
                while (_local2--) {
                    _local11 = this._orientData[_local2];
                    this.changeFactor = (_arg1 + ((_local11[4]) || (0.01)));
                    _local12 = ((_local11[3]) || (0));
                    _local9 = (this._future[_local11[0]] - _local8[_local11[0]]);
                    _local10 = (this._future[_local11[1]] - _local8[_local11[1]]);
                    _local13[_local11[2]] = ((Math.atan2(_local10, _local9) * _RAD2DEG) + _local12);
                };
                this._target = _local13;
                this.round = _local14;
                this._orient = true;
            };
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class BlurFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["blurX", "blurY", "quality"];

        public function BlurFilterPlugin(){
            this.propName = "blurFilter";
            this.overwriteProps = ["blurFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = BlurFilter;
            initFilter(_arg2, new BlurFilter(0, 0, ((_arg2.quality) || (2))), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.core.*;
    import flash.filters.*;

    public class FilterPlugin extends TweenPlugin {

        public static const VERSION:Number = 2.03;
        public static const API:Number = 1;

        protected var _target:Object;
        protected var _type:Class;
        protected var _filter:BitmapFilter;
        protected var _index:int;
        protected var _remove:Boolean;

        protected function initFilter(_arg1:Object, _arg2:BitmapFilter, _arg3:Array):void{
            var _local5:String;
            var _local6:int;
            var _local7:HexColorsPlugin;
            var _local4:Array = this._target.filters;
            var _local8:Object = (((_arg1 is BitmapFilter)) ? {} : _arg1);
            this._index = -1;
            if (_local8.index != null){
                this._index = _local8.index;
            } else {
                _local6 = _local4.length;
                while (_local6--) {
                    if ((_local4[_local6] is this._type)){
                        this._index = _local6;
                        break;
                    };
                };
            };
            if ((((((this._index == -1)) || ((_local4[this._index] == null)))) || ((_local8.addFilter == true)))){
                this._index = ((_local8.index)!=null) ? _local8.index : _local4.length;
                _local4[this._index] = _arg2;
                this._target.filters = _local4;
            };
            this._filter = _local4[this._index];
            if (_local8.remove == true){
                this._remove = true;
                this.onComplete = this.onCompleteTween;
            };
            _local6 = _arg3.length;
            while (_local6--) {
                _local5 = _arg3[_local6];
                if ((((_local5 in _arg1)) && (!((this._filter[_local5] == _arg1[_local5]))))){
                    if ((((((_local5 == "color")) || ((_local5 == "highlightColor")))) || ((_local5 == "shadowColor")))){
                        _local7 = new HexColorsPlugin();
                        _local7.initColor(this._filter, _local5, this._filter[_local5], _arg1[_local5]);
                        _tweens[_tweens.length] = new PropTween(_local7, "changeFactor", 0, 1, _local5, false);
                    } else {
                        if ((((((((_local5 == "quality")) || ((_local5 == "inner")))) || ((_local5 == "knockout")))) || ((_local5 == "hideObject")))){
                            this._filter[_local5] = _arg1[_local5];
                        } else {
                            addTween(this._filter, _local5, this._filter[_local5], _arg1[_local5], _local5);
                        };
                    };
                };
            };
        }
        public function onCompleteTween():void{
            var _local1:Array;
            var _local2:int;
            if (this._remove){
                _local1 = this._target.filters;
                if (!(_local1[this._index] is this._type)){
                    _local2 = _local1.length;
                    while (_local2--) {
                        if ((_local1[_local2] is this._type)){
                            _local1.splice(_local2, 1);
                            break;
                        };
                    };
                } else {
                    _local1.splice(this._index, 1);
                };
                this._target.filters = _local1;
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local3:PropTween;
            var _local2:int = _tweens.length;
            var _local4:Array = this._target.filters;
            while (_local2--) {
                _local3 = _tweens[_local2];
                _local3.target[_local3.property] = (_local3.start + (_local3.change * _arg1));
            };
            if (!(_local4[this._index] is this._type)){
                _local2 = (this._index = _local4.length);
                while (_local2--) {
                    if ((_local4[_local2] is this._type)){
                        this._index = _local2;
                        break;
                    };
                };
            };
            _local4[this._index] = this._filter;
            this._target.filters = _local4;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class EndArrayPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _a:Array;
        protected var _info:Array;

        public function EndArrayPlugin(){
            this._info = [];
            super();
            this.propName = "endArray";
            this.overwriteProps = ["endArray"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (((!((_arg1 is Array))) || (!((_arg2 is Array))))){
                return (false);
            };
            this.init((_arg1 as Array), _arg2);
            return (true);
        }
        public function init(_arg1:Array, _arg2:Array):void{
            this._a = _arg1;
            var _local3:int = _arg2.length;
            while (_local3--) {
                if (((!((_arg1[_local3] == _arg2[_local3]))) && (!((_arg1[_local3] == null))))){
                    this._info[this._info.length] = new ArrayTweenInfo(_local3, this._a[_local3], (_arg2[_local3] - this._a[_local3]));
                };
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local3:ArrayTweenInfo;
            var _local4:Number;
            var _local2:int = this._info.length;
            if (this.round){
                while (_local2--) {
                    _local3 = this._info[_local2];
                    _local4 = (_local3.start + (_local3.change * _arg1));
                    if (_local4 > 0){
                        this._a[_local3.index] = ((_local4 + 0.5) >> 0);
                    } else {
                        this._a[_local3.index] = ((_local4 - 0.5) >> 0);
                    };
                };
            } else {
                while (_local2--) {
                    _local3 = this._info[_local2];
                    this._a[_local3.index] = (_local3.start + (_local3.change * _arg1));
                };
            };
        }

    }
}//package com.greensock.plugins 

class ArrayTweenInfo {

    public var index:uint;
    public var start:Number;
    public var change:Number;

    public function ArrayTweenInfo(_arg1:uint, _arg2:Number, _arg3:Number){
        this.index = _arg1;
        this.start = _arg2;
        this.change = _arg3;
    }
}
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class VisiblePlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _tween:TweenLite;
        protected var _visible:Boolean;
        protected var _initVal:Boolean;

        public function VisiblePlugin(){
            this.propName = "visible";
            this.overwriteProps = ["visible"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._target = _arg1;
            this._tween = _arg3;
            this._initVal = this._target.visible;
            this._visible = Boolean(_arg2);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            if ((((_arg1 == 1)) && ((((this._tween.cachedDuration == this._tween.cachedTime)) || ((this._tween.cachedTime == 0)))))){
                this._target.visible = this._visible;
            } else {
                this._target.visible = this._initVal;
            };
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class ColorMatrixFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = [];
        protected static var _idMatrix:Array = [1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0];
        protected static var _lumR:Number = 0.212671;
        protected static var _lumG:Number = 0.71516;
        protected static var _lumB:Number = 0.072169;

        protected var _matrix:Array;
        protected var _matrixTween:EndArrayPlugin;

        public function ColorMatrixFilterPlugin(){
            this.propName = "colorMatrixFilter";
            this.overwriteProps = ["colorMatrixFilter"];
        }
        public static function colorize(_arg1:Array, _arg2:Number, _arg3:Number=1):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            if (isNaN(_arg3)){
                _arg3 = 1;
            };
            var _local4:Number = (((_arg2 >> 16) & 0xFF) / 0xFF);
            var _local5:Number = (((_arg2 >> 8) & 0xFF) / 0xFF);
            var _local6:Number = ((_arg2 & 0xFF) / 0xFF);
            var _local7:Number = (1 - _arg3);
            var _local8:Array = [(_local7 + ((_arg3 * _local4) * _lumR)), ((_arg3 * _local4) * _lumG), ((_arg3 * _local4) * _lumB), 0, 0, ((_arg3 * _local5) * _lumR), (_local7 + ((_arg3 * _local5) * _lumG)), ((_arg3 * _local5) * _lumB), 0, 0, ((_arg3 * _local6) * _lumR), ((_arg3 * _local6) * _lumG), (_local7 + ((_arg3 * _local6) * _lumB)), 0, 0, 0, 0, 0, 1, 0];
            return (applyMatrix(_local8, _arg1));
        }
        public static function setThreshold(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            var _local3:Array = [(_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), (_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), (_lumR * 0x0100), (_lumG * 0x0100), (_lumB * 0x0100), 0, (-256 * _arg2), 0, 0, 0, 1, 0];
            return (applyMatrix(_local3, _arg1));
        }
        public static function setHue(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = (_arg2 * (Math.PI / 180));
            var _local3:Number = Math.cos(_arg2);
            var _local4:Number = Math.sin(_arg2);
            var _local5:Array = [((_lumR + (_local3 * (1 - _lumR))) + (_local4 * -(_lumR))), ((_lumG + (_local3 * -(_lumG))) + (_local4 * -(_lumG))), ((_lumB + (_local3 * -(_lumB))) + (_local4 * (1 - _lumB))), 0, 0, ((_lumR + (_local3 * -(_lumR))) + (_local4 * 0.143)), ((_lumG + (_local3 * (1 - _lumG))) + (_local4 * 0.14)), ((_lumB + (_local3 * -(_lumB))) + (_local4 * -0.283)), 0, 0, ((_lumR + (_local3 * -(_lumR))) + (_local4 * -((1 - _lumR)))), ((_lumG + (_local3 * -(_lumG))) + (_local4 * _lumG)), ((_lumB + (_local3 * (1 - _lumB))) + (_local4 * _lumB)), 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1];
            return (applyMatrix(_local5, _arg1));
        }
        public static function setBrightness(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = ((_arg2 * 100) - 100);
            return (applyMatrix([1, 0, 0, 0, _arg2, 0, 1, 0, 0, _arg2, 0, 0, 1, 0, _arg2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1], _arg1));
        }
        public static function setSaturation(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            var _local3:Number = (1 - _arg2);
            var _local4:Number = (_local3 * _lumR);
            var _local5:Number = (_local3 * _lumG);
            var _local6:Number = (_local3 * _lumB);
            var _local7:Array = [(_local4 + _arg2), _local5, _local6, 0, 0, _local4, (_local5 + _arg2), _local6, 0, 0, _local4, _local5, (_local6 + _arg2), 0, 0, 0, 0, 0, 1, 0];
            return (applyMatrix(_local7, _arg1));
        }
        public static function setContrast(_arg1:Array, _arg2:Number):Array{
            if (isNaN(_arg2)){
                return (_arg1);
            };
            _arg2 = (_arg2 + 0.01);
            var _local3:Array = [_arg2, 0, 0, 0, (128 * (1 - _arg2)), 0, _arg2, 0, 0, (128 * (1 - _arg2)), 0, 0, _arg2, 0, (128 * (1 - _arg2)), 0, 0, 0, 1, 0];
            return (applyMatrix(_local3, _arg1));
        }
        public static function applyMatrix(_arg1:Array, _arg2:Array):Array{
            var _local6:int;
            var _local7:int;
            if (((!((_arg1 is Array))) || (!((_arg2 is Array))))){
                return (_arg2);
            };
            var _local3:Array = [];
            var _local4:int;
            var _local5:int;
            _local6 = 0;
            while (_local6 < 4) {
                _local7 = 0;
                while (_local7 < 5) {
                    if (_local7 == 4){
                        _local5 = _arg1[(_local4 + 4)];
                    } else {
                        _local5 = 0;
                    };
                    _local3[(_local4 + _local7)] = (((((_arg1[_local4] * _arg2[_local7]) + (_arg1[(_local4 + 1)] * _arg2[(_local7 + 5)])) + (_arg1[(_local4 + 2)] * _arg2[(_local7 + 10)])) + (_arg1[(_local4 + 3)] * _arg2[(_local7 + 15)])) + _local5);
                    _local7 = (_local7 + 1);
                };
                _local4 = (_local4 + 5);
                _local6 = (_local6 + 1);
            };
            return (_local3);
        }

        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = ColorMatrixFilter;
            var _local4:Object = _arg2;
            initFilter({
                remove:_arg2.remove,
                index:_arg2.index,
                addFilter:_arg2.addFilter
            }, new ColorMatrixFilter(_idMatrix.slice()), _propNames);
            this._matrix = ColorMatrixFilter(_filter).matrix;
            var _local5:Array = [];
            if (((!((_local4.matrix == null))) && ((_local4.matrix is Array)))){
                _local5 = _local4.matrix;
            } else {
                if (_local4.relative == true){
                    _local5 = this._matrix.slice();
                } else {
                    _local5 = _idMatrix.slice();
                };
                _local5 = setBrightness(_local5, _local4.brightness);
                _local5 = setContrast(_local5, _local4.contrast);
                _local5 = setHue(_local5, _local4.hue);
                _local5 = setSaturation(_local5, _local4.saturation);
                _local5 = setThreshold(_local5, _local4.threshold);
                if (!isNaN(_local4.colorize)){
                    _local5 = colorize(_local5, _local4.colorize, _local4.amount);
                };
            };
            this._matrixTween = new EndArrayPlugin();
            this._matrixTween.init(this._matrix, _local5);
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            this._matrixTween.changeFactor = _arg1;
            ColorMatrixFilter(_filter).matrix = this._matrix;
            super.changeFactor = _arg1;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class BevelFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["distance", "angle", "highlightColor", "highlightAlpha", "shadowColor", "shadowAlpha", "blurX", "blurY", "strength", "quality"];

        public function BevelFilterPlugin(){
            this.propName = "bevelFilter";
            this.overwriteProps = ["bevelFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = BevelFilter;
            initFilter(_arg2, new BevelFilter(0, 0, 0xFFFFFF, 0.5, 0, 0.5, 2, 2, 0, ((_arg2.quality) || (2))), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {

    public class RemoveTintPlugin extends TintPlugin {

        public static const API:Number = 1;

        public function RemoveTintPlugin(){
            this.propName = "removeTint";
        }
    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.media.*;

    public class VolumePlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _st:SoundTransform;

        public function VolumePlugin(){
            this.propName = "volume";
            this.overwriteProps = ["volume"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (((((isNaN(_arg2)) || (_arg1.hasOwnProperty("volume")))) || (!(_arg1.hasOwnProperty("soundTransform"))))){
                return (false);
            };
            this._target = _arg1;
            this._st = this._target.soundTransform;
            addTween(this._st, "volume", this._st.volume, _arg2, "volume");
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            this._target.soundTransform = this._st;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import flash.display.*;
    import com.greensock.*;

    public class FrameLabelPlugin extends FramePlugin {

        public static const API:Number = 1;

        public function FrameLabelPlugin(){
            this.propName = "frameLabel";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if ((!(_arg3.target) is MovieClip)){
                return (false);
            };
            _target = (_arg1 as MovieClip);
            this.frame = _target.currentFrame;
            var _local4:Array = _target.currentLabels;
            var _local5:String = _arg2;
            var _local6:int = _target.currentFrame;
            var _local7:int = _local4.length;
            while (_local7--) {
                if (_local4[_local7].name == _local5){
                    _local6 = _local4[_local7].frame;
                    break;
                };
            };
            if (this.frame != _local6){
                addTween(this, "frame", this.frame, _local6, "frame");
            };
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import flash.display.*;
    import com.greensock.*;
    import flash.geom.*;

    public class ColorTransformPlugin extends TintPlugin {

        public static const API:Number = 1;

        public function ColorTransformPlugin(){
            this.propName = "colorTransform";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local5:String;
            var _local6:Number;
            if (!(_arg1 is DisplayObject)){
                return (false);
            };
            var _local4:ColorTransform = _arg1.transform.colorTransform;
            for (_local5 in _arg2) {
                if ((((_local5 == "tint")) || ((_local5 == "color")))){
                    if (_arg2[_local5] != null){
                        _local4.color = int(_arg2[_local5]);
                    };
                } else {
                    if ((((((_local5 == "tintAmount")) || ((_local5 == "exposure")))) || ((_local5 == "brightness")))){
                    } else {
                        _local4[_local5] = _arg2[_local5];
                    };
                };
            };
            if (!isNaN(_arg2.tintAmount)){
                _local6 = (_arg2.tintAmount / (1 - (((_local4.redMultiplier + _local4.greenMultiplier) + _local4.blueMultiplier) / 3)));
                _local4.redOffset = (_local4.redOffset * _local6);
                _local4.greenOffset = (_local4.greenOffset * _local6);
                _local4.blueOffset = (_local4.blueOffset * _local6);
                _local4.redMultiplier = (_local4.greenMultiplier = (_local4.blueMultiplier = (1 - _arg2.tintAmount)));
            } else {
                if (!isNaN(_arg2.exposure)){
                    _local4.redOffset = (_local4.greenOffset = (_local4.blueOffset = (0xFF * (_arg2.exposure - 1))));
                    _local4.redMultiplier = (_local4.greenMultiplier = (_local4.blueMultiplier = 1));
                } else {
                    if (!isNaN(_arg2.brightness)){
                        _local4.redOffset = (_local4.greenOffset = (_local4.blueOffset = Math.max(0, ((_arg2.brightness - 1) * 0xFF))));
                        _local4.redMultiplier = (_local4.greenMultiplier = (_local4.blueMultiplier = (1 - Math.abs((_arg2.brightness - 1)))));
                    };
                };
            };
            _ignoreAlpha = Boolean(((!((_arg3.vars.alpha == undefined))) && ((_arg2.alphaMultiplier == undefined))));
            init((_arg1 as DisplayObject), _local4);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import flash.display.*;
    import com.greensock.core.*;
    import com.greensock.*;
    import flash.geom.*;

    public class TintPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected static var _props:Array = ["redMultiplier", "greenMultiplier", "blueMultiplier", "alphaMultiplier", "redOffset", "greenOffset", "blueOffset", "alphaOffset"];

        protected var _transform:Transform;
        protected var _ct:ColorTransform;
        protected var _ignoreAlpha:Boolean;

        public function TintPlugin(){
            this.propName = "tint";
            this.overwriteProps = ["tint"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg1 is DisplayObject)){
                return (false);
            };
            var _local4:ColorTransform = new ColorTransform();
            if (((!((_arg2 == null))) && (!((_arg3.vars.removeTint == true))))){
                _local4.color = uint(_arg2);
            };
            this._ignoreAlpha = true;
            this.init((_arg1 as DisplayObject), _local4);
            return (true);
        }
        public function init(_arg1:DisplayObject, _arg2:ColorTransform):void{
            var _local4:String;
            this._transform = _arg1.transform;
            this._ct = this._transform.colorTransform;
            var _local3:int = _props.length;
            while (_local3--) {
                _local4 = _props[_local3];
                if (this._ct[_local4] != _arg2[_local4]){
                    _tweens[_tweens.length] = new PropTween(this._ct, _local4, this._ct[_local4], (_arg2[_local4] - this._ct[_local4]), "tint", false);
                };
            };
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local2:ColorTransform;
            updateTweens(_arg1);
            if (this._ignoreAlpha){
                _local2 = this._transform.colorTransform;
                this._ct.alphaMultiplier = _local2.alphaMultiplier;
                this._ct.alphaOffset = _local2.alphaOffset;
            };
            this._transform.colorTransform = this._ct;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class BezierThroughPlugin extends BezierPlugin {

        public static const API:Number = 1;

        public function BezierThroughPlugin(){
            this.propName = "bezierThrough";
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (!(_arg2 is Array)){
                return (false);
            };
            init(_arg3, (_arg2 as Array), true);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class GlowFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout"];

        public function GlowFilterPlugin(){
            this.propName = "glowFilter";
            this.overwriteProps = ["glowFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = GlowFilter;
            initFilter(_arg2, new GlowFilter(0xFFFFFF, 0, 0, 0, ((_arg2.strength) || (1)), ((_arg2.quality) || (2)), _arg2.inner, _arg2.knockout), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class HexColorsPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _colors:Array;

        public function HexColorsPlugin(){
            this.propName = "hexColors";
            this.overwriteProps = [];
            this._colors = [];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local4:String;
            for (_local4 in _arg2) {
                this.initColor(_arg1, _local4, uint(_arg1[_local4]), uint(_arg2[_local4]));
            };
            return (true);
        }
        public function initColor(_arg1:Object, _arg2:String, _arg3:uint, _arg4:uint):void{
            var _local5:Number;
            var _local6:Number;
            var _local7:Number;
            if (_arg3 != _arg4){
                _local5 = (_arg3 >> 16);
                _local6 = ((_arg3 >> 8) & 0xFF);
                _local7 = (_arg3 & 0xFF);
                this._colors[this._colors.length] = [_arg1, _arg2, _local5, ((_arg4 >> 16) - _local5), _local6, (((_arg4 >> 8) & 0xFF) - _local6), _local7, ((_arg4 & 0xFF) - _local7)];
                this.overwriteProps[this.overwriteProps.length] = _arg2;
            };
        }
        override public function killProps(_arg1:Object):void{
            var _local2:int = (this._colors.length - 1);
            while (_local2 > -1) {
                if (_arg1[this._colors[_local2][1]] != undefined){
                    this._colors.splice(_local2, 1);
                };
                _local2--;
            };
            super.killProps(_arg1);
        }
        override public function set changeFactor(_arg1:Number):void{
            var _local3:Array;
            var _local2:int = this._colors.length;
            while (--_local2 > -1) {
                _local3 = this._colors[_local2];
                _local3[0][_local3[1]] = ((((_local3[2] + (_arg1 * _local3[3])) << 16) | ((_local3[4] + (_arg1 * _local3[5])) << 8)) | (_local3[6] + (_arg1 * _local3[7])));
            };
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class AutoAlphaPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _target:Object;
        protected var _ignoreVisible:Boolean;

        public function AutoAlphaPlugin(){
            this.propName = "autoAlpha";
            this.overwriteProps = ["alpha", "visible"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._target = _arg1;
            addTween(_arg1, "alpha", _arg1.alpha, _arg2, "alpha");
            return (true);
        }
        override public function killProps(_arg1:Object):void{
            super.killProps(_arg1);
            this._ignoreVisible = Boolean(("visible" in _arg1));
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            if (!this._ignoreVisible){
                this._target.visible = Boolean(!((this._target.alpha == 0)));
            };
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;
    import flash.filters.*;

    public class DropShadowFilterPlugin extends FilterPlugin {

        public static const API:Number = 1;

        private static var _propNames:Array = ["distance", "angle", "color", "alpha", "blurX", "blurY", "strength", "quality", "inner", "knockout", "hideObject"];

        public function DropShadowFilterPlugin(){
            this.propName = "dropShadowFilter";
            this.overwriteProps = ["dropShadowFilter"];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            _target = _arg1;
            _type = DropShadowFilter;
            initFilter(_arg2, new DropShadowFilter(0, 45, 0, 0, 0, 0, 1, ((_arg2.quality) || (2)), _arg2.inner, _arg2.knockout, _arg2.hideObject), _propNames);
            return (true);
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.core.*;
    import com.greensock.*;

    public class TweenPlugin {

        public static const VERSION:Number = 1.4;
        public static const API:Number = 1;

        public var propName:String;
        public var overwriteProps:Array;
        public var round:Boolean;
        public var priority:int = 0;
        public var activeDisable:Boolean;
        public var onInitAllProps:Function;
        public var onComplete:Function;
        public var onEnable:Function;
        public var onDisable:Function;
        protected var _tweens:Array;
        protected var _changeFactor:Number = 0;

        public function TweenPlugin(){
            this._tweens = [];
            super();
        }
        private static function onTweenEvent(_arg1:String, _arg2:TweenLite):Boolean{
            var _local4:Boolean;
            var _local5:Array;
            var _local6:int;
            var _local3:PropTween = _arg2.cachedPT1;
            if (_arg1 == "onInitAllProps"){
                _local5 = [];
                _local6 = 0;
                while (_local3) {
                    var _temp1 = _local6;
                    _local6 = (_local6 + 1);
                    var _local7 = _temp1;
                    _local5[_local7] = _local3;
                    _local3 = _local3.nextNode;
                };
                _local5.sortOn("priority", (Array.NUMERIC | Array.DESCENDING));
                while (--_local6 > -1) {
                    PropTween(_local5[_local6]).nextNode = _local5[(_local6 + 1)];
                    PropTween(_local5[_local6]).prevNode = _local5[(_local6 - 1)];
                };
                _local3 = (_arg2.cachedPT1 = _local5[0]);
            };
            while (_local3) {
                if (((_local3.isPlugin) && (_local3.target[_arg1]))){
                    if (_local3.target.activeDisable){
                        _local4 = true;
                    };
                    _local7 = _local3.target;
                    _local7[_arg1]();
                };
                _local3 = _local3.nextNode;
            };
            return (_local4);
        }
        public static function activate(_arg1:Array):Boolean{
            var _local3:Object;
            TweenLite.onPluginEvent = TweenPlugin.onTweenEvent;
            var _local2:int = _arg1.length;
            while (_local2--) {
                if (_arg1[_local2].hasOwnProperty("API")){
                    _local3 = new ((_arg1[_local2] as Class))();
                    TweenLite.plugins[_local3.propName] = _arg1[_local2];
                };
            };
            return (true);
        }

        public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this.addTween(_arg1, this.propName, _arg1[this.propName], _arg2, this.propName);
            return (true);
        }
        protected function addTween(_arg1:Object, _arg2:String, _arg3:Number, _arg4, _arg5:String=null):void{
            var _local6:Number;
            if (_arg4 != null){
                _local6 = ((typeof(_arg4))=="number") ? (Number(_arg4) - _arg3) : Number(_arg4);
                if (_local6 != 0){
                    this._tweens[this._tweens.length] = new PropTween(_arg1, _arg2, _arg3, _local6, ((_arg5) || (_arg2)), false);
                };
            };
        }
        protected function updateTweens(_arg1:Number):void{
            var _local3:PropTween;
            var _local4:Number;
            var _local2:int = this._tweens.length;
            if (this.round){
                while (--_local2 > -1) {
                    _local3 = this._tweens[_local2];
                    _local4 = (_local3.start + (_local3.change * _arg1));
                    if (_local4 > 0){
                        _local3.target[_local3.property] = ((_local4 + 0.5) >> 0);
                    } else {
                        _local3.target[_local3.property] = ((_local4 - 0.5) >> 0);
                    };
                };
            } else {
                while (--_local2 > -1) {
                    _local3 = this._tweens[_local2];
                    _local3.target[_local3.property] = (_local3.start + (_local3.change * _arg1));
                };
            };
        }
        public function get changeFactor():Number{
            return (this._changeFactor);
        }
        public function set changeFactor(_arg1:Number):void{
            this.updateTweens(_arg1);
            this._changeFactor = _arg1;
        }
        public function killProps(_arg1:Object):void{
            var _local2:int = this.overwriteProps.length;
            while (--_local2 > -1) {
                if ((this.overwriteProps[_local2] in _arg1)){
                    this.overwriteProps.splice(_local2, 1);
                };
            };
            _local2 = this._tweens.length;
            while (--_local2 > -1) {
                if ((PropTween(this._tweens[_local2]).name in _arg1)){
                    this._tweens.splice(_local2, 1);
                };
            };
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.core.*;
    import com.greensock.*;

    public class RoundPropsPlugin extends TweenPlugin {

        public static const API:Number = 1;

        protected var _tween:TweenLite;

        public function RoundPropsPlugin(){
            this.propName = "roundProps";
            this.overwriteProps = ["roundProps"];
            this.round = true;
            this.priority = -1;
            this.onInitAllProps = this._initAllProps;
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            this._tween = _arg3;
            this.overwriteProps = this.overwriteProps.concat((_arg2 as Array));
            return (true);
        }
        protected function _initAllProps():void{
            var _local1:String;
            var _local2:String;
            var _local4:PropTween;
            var _local3:Array = this._tween.vars.roundProps;
            var _local5:int = _local3.length;
            while (--_local5 > -1) {
                _local1 = _local3[_local5];
                _local4 = this._tween.cachedPT1;
                while (_local4) {
                    if (_local4.name == _local1){
                        if (_local4.isPlugin){
                            _local4.target.round = true;
                        } else {
                            this.add(_local4.target, _local1, _local4.start, _local4.change);
                            this._removePropTween(_local4);
                            this._tween.propTweenLookup[_local1] = this._tween.propTweenLookup.roundProps;
                        };
                    } else {
                        if (((((_local4.isPlugin) && ((_local4.name == "_MULTIPLE_")))) && (!(_local4.target.round)))){
                            _local2 = ((" " + _local4.target.overwriteProps.join(" ")) + " ");
                            if (_local2.indexOf(((" " + _local1) + " ")) != -1){
                                _local4.target.round = true;
                            };
                        };
                    };
                    _local4 = _local4.nextNode;
                };
            };
        }
        protected function _removePropTween(_arg1:PropTween):void{
            if (_arg1.nextNode){
                _arg1.nextNode.prevNode = _arg1.prevNode;
            };
            if (_arg1.prevNode){
                _arg1.prevNode.nextNode = _arg1.nextNode;
            } else {
                if (this._tween.cachedPT1 == _arg1){
                    this._tween.cachedPT1 = _arg1.nextNode;
                };
            };
            if (((_arg1.isPlugin) && (_arg1.target.onDisable))){
                _arg1.target.onDisable();
            };
        }
        public function add(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number):void{
            addTween(_arg1, _arg2, _arg3, (_arg3 + _arg4), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import com.greensock.*;

    public class ShortRotationPlugin extends TweenPlugin {

        public static const API:Number = 1;

        public function ShortRotationPlugin(){
            this.propName = "shortRotation";
            this.overwriteProps = [];
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            var _local4:String;
            if (typeof(_arg2) == "number"){
                return (false);
            };
            for (_local4 in _arg2) {
                this.initRotation(_arg1, _local4, _arg1[_local4], ((typeof(_arg2[_local4]))=="number") ? Number(_arg2[_local4]) : (_arg1[_local4] + Number(_arg2[_local4])));
            };
            return (true);
        }
        public function initRotation(_arg1:Object, _arg2:String, _arg3:Number, _arg4:Number):void{
            var _local5:Number = ((_arg4 - _arg3) % 360);
            if (((_arg4 - _arg3) % 360) != (_local5 % 180)){
                _local5 = ((_local5)<0) ? (_local5 + 360) : (_local5 - 360);
            };
            addTween(_arg1, _arg2, _arg3, (_arg3 + _local5), _arg2);
            this.overwriteProps[this.overwriteProps.length] = _arg2;
        }

    }
}//package com.greensock.plugins 
﻿package com.greensock.plugins {
    import flash.display.*;
    import com.greensock.*;

    public class FramePlugin extends TweenPlugin {

        public static const API:Number = 1;

        public var frame:int;
        protected var _target:MovieClip;

        public function FramePlugin(){
            this.propName = "frame";
            this.overwriteProps = ["frame", "frameLabel"];
            this.round = true;
        }
        override public function onInitTween(_arg1:Object, _arg2, _arg3:TweenLite):Boolean{
            if (((!((_arg1 is MovieClip))) || (isNaN(_arg2)))){
                return (false);
            };
            this._target = (_arg1 as MovieClip);
            this.frame = this._target.currentFrame;
            addTween(this, "frame", this.frame, _arg2, "frame");
            return (true);
        }
        override public function set changeFactor(_arg1:Number):void{
            updateTweens(_arg1);
            this._target.gotoAndStop(this.frame);
        }

    }
}//package com.greensock.plugins
