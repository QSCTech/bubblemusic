		package as3.Bottom
		{
			import as3.PlayControl.playControl;
			
    		import flash.filters.BevelFilter;
  			import mx.skins.ProgrammaticSkin;
 
 		    public class playButtonSkin 
 		    {
    
        	  if(!isPlay) { 
         	     switch( name )
        	     {
       	        	 case "upSkin":
       	            	Embed(source="../Style/play.png");
            	        break;
       	       	     case "overSkin":
                        Embed(source="../Style/play.png");
                        break;
                     case "downSkin":
                        Embed(source="../Style/play.png");
                        break;
                     case "disabledSkin":
                        Embed(source="../Style/play.png");
                        break;
                 } 
            }
              else{
                  switch( name )
                  {
                	  case "upSkin":
                   		 Embed(source="../Style/pause.png");
                   		 break;
               	      case "overSkin":
                  		 Embed(source="../Style/pause.png");
                    	 break;
                      case "downSkin":
                   	 	 Embed(source="../Style/pause.png");
                   		 break;
                      case "disabledSkin":
                  		 Embed(source="../Style/pause.png");
                  		 break;
                  }
              }	
		 }