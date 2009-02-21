// ------------------------------------------------------------------
//Module:			RotateControl
//
//Description:		Buttons for spin
//
//Input:			mouse click
//				
//Output:			event to signal direction
//					- direction: left, right, up, down
//				
//Author(s):		- CT Yeung
//				
//History:
//31Aug08			binary tree and display completed			(cty)
//28Sep08			working on spin capability, need scaling & offset.	(cty)
// ------------------------------------------------------------------
package com
{
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.containers.Canvas;
	import mx.controls.Image;
	
	[Event(name="rotateClicked", type="flash.events.Event")]
	
	public class RotateControl extends Canvas
	{
		[Bindable][Embed(source="/assets/arrowUp.png")]public var upClass:Class;
		[Bindable][Embed(source="/assets/arrowDown.png")]public var downClass:Class;
		[Bindable][Embed(source="/assets/arrowLeft.png")]public var leftClass:Class;
		[Bindable][Embed(source="/assets/arrowRight.png")]public var rightClass:Class;
		protected var imgLeft:Image;
		protected var imgRight:Image;
		protected var imgUp:Image;
		protected var imgDown:Image;
		protected var center:Point;
		public var direction:String;
		
		public function RotateControl()
		{
			center = new Point();
			center.x = (width)?width/2:50;
			center.y = (height)?height/2:50;

			width = (width)?width:100;
			height = (height)?height:100;
			
			onInitArrow(imgLeft, leftClass, "left", new Point(0, height/3));
			onInitArrow(imgRight, rightClass, "right", new Point(width/3*2, height/3));
			onInitArrow(imgUp, upClass, "up", new Point(width/3, 0));
			onInitArrow(imgDown, downClass, "down", new Point(width/3, height/3*2));
		}
		
		protected function onInitArrow(	img:Image,
							  			objClass:Class,
							  			id:String,
							  			pos:Point):void
		{
			img = new Image();
			img.source = new Bitmap(new objClass().bitmapData);
			img.addEventListener(MouseEvent.ROLL_OUT, onRollOut);
			img.addEventListener(MouseEvent.ROLL_OVER, onRollOver);
			img.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			img.addEventListener(MouseEvent.MOUSE_UP, onRollOver);
			img.id = id;
			img.useHandCursor=true;
			img.buttonMode=true;
			this.addChild(img);
			img.x = pos.x;
			img.y = pos.y;
		}		  
		
		
		protected function onMouseDown(e:MouseEvent):void
		{
			var img:Image = e.currentTarget as Image;
			img.alpha = .2;
			direction = img.id.toString();
			dispatchEvent(new Event("rotateClicked"));
		}
		
		protected function onRollOver(e:MouseEvent):void
		{
			var img:Image = e.currentTarget as Image;
			img.alpha = .8;
		}
		
		protected function onRollOut(e:MouseEvent):void
		{
			var img:Image = e.currentTarget as Image;
			img.alpha = 1;
		}
	}

}// ActionScript file
