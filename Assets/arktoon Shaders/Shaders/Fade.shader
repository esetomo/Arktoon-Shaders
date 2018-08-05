// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:9361,x:34796,y:33365,varname:node_9361,prsc:2|normal-7164-RGB,emission-1817-OUT,custl-7257-OUT,olwid-7067-OUT,olcol-5057-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:8068,x:32323,y:34884,varname:node_8068,prsc:2;n:type:ShaderForge.SFN_LightColor,id:3406,x:32194,y:34793,varname:node_3406,prsc:2;n:type:ShaderForge.SFN_LightVector,id:6869,x:31581,y:34422,varname:node_6869,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:9684,x:31581,y:34550,prsc:2,pt:True;n:type:ShaderForge.SFN_HalfVector,id:9471,x:31581,y:34701,varname:node_9471,prsc:2;n:type:ShaderForge.SFN_Dot,id:7782,x:31793,y:34465,cmnt:Lambert,varname:node_7782,prsc:2,dt:1|A-6869-OUT,B-9684-OUT;n:type:ShaderForge.SFN_Dot,id:3269,x:31793,y:34639,cmnt:Blinn-Phong,varname:node_3269,prsc:2,dt:1|A-9684-OUT,B-9471-OUT;n:type:ShaderForge.SFN_Multiply,id:2746,x:32188,y:34634,cmnt:Specular Contribution,varname:node_2746,prsc:2|A-7782-OUT,B-5267-OUT,C-4865-RGB;n:type:ShaderForge.SFN_Tex2d,id:851,x:28737,y:31575,ptovrint:False,ptlb:Base Texture,ptin:_BaseTexture,varname:node_851,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:5927,x:28737,y:31760,ptovrint:False,ptlb:Base Color,ptin:_BaseColor,varname:node_5927,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Exp,id:1700,x:31793,y:34822,varname:node_1700,prsc:2,et:1|IN-9978-OUT;n:type:ShaderForge.SFN_Slider,id:5328,x:31252,y:34824,ptovrint:False,ptlb:[Gloss] Power,ptin:_GlossPower,varname:node_5328,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.5,max:1;n:type:ShaderForge.SFN_Power,id:5267,x:31991,y:34708,varname:node_5267,prsc:2|VAL-3269-OUT,EXP-1700-OUT;n:type:ShaderForge.SFN_Multiply,id:5085,x:32629,y:34835,cmnt:Attenuate and Color,varname:node_5085,prsc:2|A-2746-OUT,B-3406-RGB,C-8068-OUT,D-9118-OUT;n:type:ShaderForge.SFN_ConstantLerp,id:9978,x:31581,y:34824,varname:node_9978,prsc:2,a:1,b:11|IN-5328-OUT;n:type:ShaderForge.SFN_Color,id:4865,x:31668,y:35007,ptovrint:False,ptlb:[Gloss] Color,ptin:_GlossColor,varname:node_4865,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:544,x:28935,y:31674,cmnt:Diffuse Color,varname:node_544,prsc:2|A-851-RGB,B-5927-RGB;n:type:ShaderForge.SFN_Slider,id:1674,x:33033,y:34316,ptovrint:False,ptlb:[Outline] Width,ptin:_OutlineWidth,varname:node_1674,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.0005,max:0.01;n:type:ShaderForge.SFN_Get,id:6803,x:33520,y:34824,varname:node_6803,prsc:2|IN-5118-OUT;n:type:ShaderForge.SFN_Slider,id:1966,x:33366,y:34729,ptovrint:False,ptlb:[Outline] Texture Color Rate,ptin:_OutlineTextureColorRate,varname:node_1966,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.05,max:1;n:type:ShaderForge.SFN_Code,id:9362,x:30083,y:32146,varname:node_9362,prsc:2,code:cgBlAHQAdQByAG4AIABTAGgAYQBkAGUAUwBIADkAKABoAGEAbABmADQAKAAwAC4AMAAsACAALQAxAC4AMAAsACAAMAAuADAALAAgADEALgAwACkAKQA7AAoA,output:2,fname:ShadeSH9Indirect,width:476,height:132;n:type:ShaderForge.SFN_Code,id:2014,x:30080,y:31979,varname:node_2014,prsc:2,code:cgBlAHQAdQByAG4AIABTAGgAYQBkAGUAUwBIADkAKABoAGEAbABmADQAKAAwAC4AMAAsACAAMQAuADAALAAgADAALgAwACwAIAAxAC4AMAApACkAOwAKAA==,output:2,fname:ShadeSH9Direct,width:489,height:132;n:type:ShaderForge.SFN_Set,id:9309,x:30663,y:31940,varname:ShadeSH9Plus,prsc:2|IN-2014-OUT;n:type:ShaderForge.SFN_Set,id:7590,x:30811,y:32114,varname:ShadeSH9Minus,prsc:2|IN-9362-OUT;n:type:ShaderForge.SFN_Code,id:8928,x:28770,y:32086,varname:node_8928,prsc:2,code:DQByAGUAdAB1AHIAbgAgAGYAbABvAGEAdAAzACgAMAAsACAAMAAuADMAOAAyADMANQAyADkALAAgADAALgAwADEAOAA0ADUAOAAzADYAKQA7AA==,output:2,fname:grayscale_vector_node,width:521,height:132;n:type:ShaderForge.SFN_Set,id:5182,x:29354,y:32162,varname:grayscale_vector,prsc:2|IN-8928-OUT;n:type:ShaderForge.SFN_Get,id:6713,x:30152,y:32416,varname:node_6713,prsc:2|IN-7590-OUT;n:type:ShaderForge.SFN_Get,id:2101,x:30108,y:32478,varname:node_2101,prsc:2|IN-5182-OUT;n:type:ShaderForge.SFN_Set,id:6050,x:30528,y:32419,varname:bottomIndirectLighting,prsc:2|IN-7943-OUT;n:type:ShaderForge.SFN_Get,id:3512,x:30152,y:32606,varname:node_3512,prsc:2|IN-9309-OUT;n:type:ShaderForge.SFN_Get,id:5864,x:30107,y:32668,varname:node_5864,prsc:2|IN-5182-OUT;n:type:ShaderForge.SFN_Set,id:3312,x:30556,y:32605,varname:topIndirectLighting,prsc:2|IN-2942-OUT;n:type:ShaderForge.SFN_Set,id:9738,x:29731,y:32465,varname:grayscaleDirectLighting,prsc:2|IN-7861-OUT;n:type:ShaderForge.SFN_NormalVector,id:6598,x:28708,y:32569,prsc:2,pt:True;n:type:ShaderForge.SFN_Dot,id:9097,x:29018,y:32406,cmnt:Lambert,varname:node_9097,prsc:2,dt:0|A-6126-OUT,B-6598-OUT;n:type:ShaderForge.SFN_LightVector,id:6126,x:28626,y:32349,varname:node_6126,prsc:2;n:type:ShaderForge.SFN_Set,id:8813,x:30759,y:32754,varname:grayscalelightcolor,prsc:2|IN-7676-OUT;n:type:ShaderForge.SFN_Dot,id:7676,x:30349,y:32758,varname:node_7676,prsc:2,dt:0|A-1050-RGB,B-4708-OUT;n:type:ShaderForge.SFN_LightColor,id:1050,x:29966,y:32726,varname:node_1050,prsc:2;n:type:ShaderForge.SFN_Get,id:4708,x:30099,y:32893,varname:node_4708,prsc:2|IN-5182-OUT;n:type:ShaderForge.SFN_Get,id:870,x:28960,y:32587,varname:node_870,prsc:2|IN-8813-OUT;n:type:ShaderForge.SFN_Multiply,id:5043,x:29188,y:32426,varname:node_5043,prsc:2|A-9097-OUT,B-870-OUT,C-8167-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:8167,x:28725,y:32817,varname:node_8167,prsc:2;n:type:ShaderForge.SFN_Add,id:7861,x:29476,y:32392,varname:node_7861,prsc:2|A-5043-OUT,B-2389-OUT;n:type:ShaderForge.SFN_Get,id:8233,x:29342,y:32876,varname:node_8233,prsc:2|IN-5182-OUT;n:type:ShaderForge.SFN_Code,id:4132,x:29021,y:32691,varname:node_4132,prsc:2,code:cgBlAHQAdQByAG4AIABTAGgAYQBkAGUAUwBIADkAKABoAGEAbABmADQAKABuAG8AcgBtAGEAbABEAGkAcgBlAGMAdABpAG8AbgAsACAAMQAuADAAKQApADsA,output:2,fname:Function_node_4132,width:430,height:132,input:2,input_1_label:normalDirection|A-6598-OUT;n:type:ShaderForge.SFN_Get,id:5131,x:28784,y:33211,varname:node_5131,prsc:2|IN-3312-OUT;n:type:ShaderForge.SFN_Get,id:925,x:28825,y:33287,varname:node_925,prsc:2|IN-8813-OUT;n:type:ShaderForge.SFN_Add,id:3137,x:29054,y:33193,varname:node_3137,prsc:2|A-5131-OUT,B-925-OUT;n:type:ShaderForge.SFN_Subtract,id:4216,x:29287,y:33253,varname:node_4216,prsc:2|A-3137-OUT,B-7998-OUT;n:type:ShaderForge.SFN_Get,id:7998,x:28949,y:33351,varname:node_7998,prsc:2|IN-6050-OUT;n:type:ShaderForge.SFN_Set,id:7731,x:29548,y:33180,varname:lightDifference,prsc:2|IN-4216-OUT;n:type:ShaderForge.SFN_Get,id:2171,x:28774,y:33645,varname:node_2171,prsc:2|IN-9738-OUT;n:type:ShaderForge.SFN_Get,id:6159,x:28747,y:33729,varname:node_6159,prsc:2|IN-6050-OUT;n:type:ShaderForge.SFN_Subtract,id:4440,x:29065,y:33645,varname:node_4440,prsc:2|A-2171-OUT,B-6159-OUT;n:type:ShaderForge.SFN_Divide,id:1751,x:29291,y:33511,varname:node_1751,prsc:2|A-4440-OUT,B-1261-OUT;n:type:ShaderForge.SFN_Get,id:1261,x:28811,y:33561,varname:node_1261,prsc:2|IN-7731-OUT;n:type:ShaderForge.SFN_Set,id:4404,x:29508,y:33511,varname:remappedLight,prsc:2|IN-1751-OUT;n:type:ShaderForge.SFN_Clamp01,id:7652,x:30196,y:33196,varname:node_7652,prsc:2|IN-4330-OUT;n:type:ShaderForge.SFN_Get,id:4330,x:29911,y:33261,varname:node_4330,prsc:2|IN-7590-OUT;n:type:ShaderForge.SFN_Set,id:4738,x:30421,y:33305,varname:indirectLighting,prsc:2|IN-7652-OUT;n:type:ShaderForge.SFN_Get,id:8829,x:29911,y:33430,varname:node_8829,prsc:2|IN-9309-OUT;n:type:ShaderForge.SFN_Clamp01,id:4821,x:30406,y:33437,varname:node_4821,prsc:2|IN-3230-OUT;n:type:ShaderForge.SFN_Set,id:3357,x:30589,y:33403,varname:directLighting,prsc:2|IN-4821-OUT;n:type:ShaderForge.SFN_Add,id:3230,x:30227,y:33437,varname:node_3230,prsc:2|A-8829-OUT,B-7533-RGB;n:type:ShaderForge.SFN_LightColor,id:7533,x:29792,y:33562,varname:node_7533,prsc:2;n:type:ShaderForge.SFN_Set,id:8358,x:29787,y:34352,varname:directContribution,prsc:2|IN-5271-OUT;n:type:ShaderForge.SFN_Get,id:9612,x:28560,y:34182,varname:node_9612,prsc:2|IN-4404-OUT;n:type:ShaderForge.SFN_Lerp,id:4133,x:31549,y:31543,varname:node_4133,prsc:2|A-2633-OUT,B-5042-OUT,T-8805-OUT;n:type:ShaderForge.SFN_Multiply,id:2542,x:31855,y:31569,varname:node_2542,prsc:2|A-9961-OUT,B-4133-OUT;n:type:ShaderForge.SFN_Get,id:2633,x:31197,y:31527,varname:node_2633,prsc:2|IN-4738-OUT;n:type:ShaderForge.SFN_Get,id:5042,x:31178,y:31611,varname:node_5042,prsc:2|IN-3357-OUT;n:type:ShaderForge.SFN_Get,id:8805,x:31300,y:31716,varname:node_8805,prsc:2|IN-8358-OUT;n:type:ShaderForge.SFN_Dot,id:2389,x:29574,y:32689,varname:node_2389,prsc:2,dt:0|A-4132-OUT,B-8233-OUT;n:type:ShaderForge.SFN_Dot,id:7943,x:30349,y:32432,cmnt:aa,varname:node_7943,prsc:2,dt:0|A-6713-OUT,B-2101-OUT;n:type:ShaderForge.SFN_Dot,id:2942,x:30387,y:32605,varname:node_2942,prsc:2,dt:0|A-3512-OUT,B-5864-OUT;n:type:ShaderForge.SFN_Set,id:5118,x:29247,y:31641,varname:Diffuse,prsc:2|IN-544-OUT;n:type:ShaderForge.SFN_Get,id:9961,x:31431,y:31435,varname:node_9961,prsc:2|IN-5118-OUT;n:type:ShaderForge.SFN_Tex2d,id:6003,x:33409,y:34375,ptovrint:False,ptlb:[Outline] Width Mask,ptin:_OutlineWidthMask,varname:node_6003,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:7067,x:33813,y:34283,varname:node_7067,prsc:2|A-1674-OUT,B-6003-R;n:type:ShaderForge.SFN_RgbToHsv,id:5443,x:29947,y:31403,varname:node_5443,prsc:2|IN-1346-OUT;n:type:ShaderForge.SFN_Get,id:1346,x:29751,y:31403,varname:node_1346,prsc:2|IN-5118-OUT;n:type:ShaderForge.SFN_Multiply,id:9480,x:30265,y:31335,varname:node_9480,prsc:2|A-5443-SOUT,B-9586-OUT;n:type:ShaderForge.SFN_Multiply,id:509,x:30265,y:31479,varname:node_509,prsc:2|A-4873-OUT,B-5443-VOUT;n:type:ShaderForge.SFN_Slider,id:8331,x:29861,y:31161,ptovrint:False,ptlb:[Shadow Plan B] Hue Shift From Base,ptin:_ShadowPlanBHueShiftFromBase,varname:node_8331,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:0,max:1;n:type:ShaderForge.SFN_Slider,id:9586,x:29861,y:31295,ptovrint:False,ptlb:[Shadow Plan B] Saturation From Base,ptin:_ShadowPlanBSaturationFromBase,varname:node_9586,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Slider,id:4873,x:29838,y:31571,ptovrint:False,ptlb:[Shadow Plan B] Value From Base,ptin:_ShadowPlanBValueFromBase,varname:node_4873,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:2;n:type:ShaderForge.SFN_HsvToRgb,id:6130,x:30512,y:31364,varname:node_6130,prsc:2|H-3407-OUT,S-9480-OUT,V-509-OUT;n:type:ShaderForge.SFN_Set,id:9081,x:30738,y:31354,varname:Diff_HSV,prsc:2|IN-6130-OUT;n:type:ShaderForge.SFN_Add,id:3407,x:30265,y:31182,varname:node_3407,prsc:2|A-8331-OUT,B-5443-HOUT;n:type:ShaderForge.SFN_Get,id:1144,x:31602,y:31336,varname:node_1144,prsc:2|IN-5118-OUT;n:type:ShaderForge.SFN_Get,id:2493,x:31398,y:30934,varname:node_2493,prsc:2|IN-9081-OUT;n:type:ShaderForge.SFN_Lerp,id:7328,x:31936,y:31328,varname:node_7328,prsc:2|A-117-OUT,B-1144-OUT,T-4133-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:5493,x:32192,y:31584,ptovrint:False,ptlb:[Shadow Plan B] Use Plan B,ptin:_ShadowPlanBUsePlanB,varname:node_5493,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2542-OUT,B-2361-OUT;n:type:ShaderForge.SFN_Divide,id:2361,x:32136,y:31306,varname:node_2361,prsc:2|A-7328-OUT,B-6893-OUT;n:type:ShaderForge.SFN_Vector1,id:6893,x:31821,y:31267,cmnt:ForwardAdd対策,varname:node_6893,prsc:2,v1:1;n:type:ShaderForge.SFN_Clamp01,id:3514,x:28767,y:34048,varname:node_3514,prsc:2|IN-9612-OUT;n:type:ShaderForge.SFN_RemapRangeAdvanced,id:7714,x:29384,y:34091,varname:node_7714,prsc:2|IN-3514-OUT,IMIN-4550-OUT,IMAX-2836-OUT,OMIN-4614-OUT,OMAX-8262-OUT;n:type:ShaderForge.SFN_Slider,id:4550,x:28989,y:34096,ptovrint:False,ptlb:[Shadow] Boarder Min,ptin:_ShadowBoarderMin,varname:node_4550,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.499,max:1;n:type:ShaderForge.SFN_Slider,id:2836,x:29020,y:34204,ptovrint:False,ptlb:[Shadow] Boarder Max,ptin:_ShadowBoarderMax,varname:node_2836,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.55,max:1;n:type:ShaderForge.SFN_Clamp01,id:2180,x:29580,y:34186,varname:node_2180,prsc:2|IN-7714-OUT;n:type:ShaderForge.SFN_Slider,id:1972,x:29031,y:34356,ptovrint:False,ptlb:[Shadow] Strength,ptin:_ShadowStrength,varname:node_1972,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_OneMinus,id:1002,x:29745,y:34105,varname:node_1002,prsc:2|IN-2180-OUT;n:type:ShaderForge.SFN_Multiply,id:1479,x:29943,y:34144,varname:node_1479,prsc:2|A-1002-OUT,B-1972-OUT;n:type:ShaderForge.SFN_OneMinus,id:5271,x:30010,y:34269,varname:node_5271,prsc:2|IN-1479-OUT;n:type:ShaderForge.SFN_Vector1,id:4614,x:28767,y:34209,varname:node_4614,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:8262,x:28806,y:34289,varname:node_8262,prsc:2,v1:1;n:type:ShaderForge.SFN_Color,id:3825,x:33701,y:34536,ptovrint:False,ptlb:[Outline] Color,ptin:_OutlineColor,varname:node_3825,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Lerp,id:5057,x:33997,y:34625,varname:node_5057,prsc:2|A-3825-RGB,B-6803-OUT,T-1966-OUT;n:type:ShaderForge.SFN_Tex2d,id:7164,x:34421,y:32553,ptovrint:False,ptlb:Normal map,ptin:_Normalmap,varname:node_7164,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2d,id:4574,x:33797,y:32113,ptovrint:False,ptlb:Emission map,ptin:_Emissionmap,varname:node_4574,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:26,x:33981,y:32275,varname:node_26,prsc:2|A-4574-RGB,B-6817-RGB;n:type:ShaderForge.SFN_Color,id:6817,x:33620,y:32223,ptovrint:False,ptlb:Emission Color,ptin:_EmissionColor,varname:node_6817,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_NormalVector,id:8154,x:27917,y:30627,prsc:2,pt:True;n:type:ShaderForge.SFN_Transform,id:3402,x:28123,y:30645,varname:node_3402,prsc:2,tffrom:0,tfto:3|IN-8154-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8025,x:28317,y:30645,varname:node_8025,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-3402-XYZ;n:type:ShaderForge.SFN_Tex2d,id:3315,x:28881,y:30571,ptovrint:False,ptlb:[Matcap] Texture,ptin:_MatcapTexture,varname:node_3315,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False|UVIN-7572-OUT;n:type:ShaderForge.SFN_Add,id:6025,x:33944,y:32409,varname:node_6025,prsc:2|A-26-OUT,B-4023-OUT;n:type:ShaderForge.SFN_Multiply,id:7200,x:29555,y:30741,varname:node_7200,prsc:2|A-1248-OUT,B-3008-RGB,C-5498-OUT;n:type:ShaderForge.SFN_Slider,id:5498,x:29510,y:30529,ptovrint:False,ptlb:[Matcap] Boost,ptin:_MatcapBoost,varname:node_5498,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:2;n:type:ShaderForge.SFN_Tex2d,id:3008,x:29107,y:30693,ptovrint:False,ptlb:[Matcap] Mask,ptin:_MatcapMask,varname:node_3008,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Code,id:12,x:29276,y:34833,varname:node_12,prsc:2,code:ZgBsAG8AYQB0ADQAIABzAGsAeQBEAGEAdABhACAAPQAgAFUATgBJAFQAWQBfAFMAQQBNAFAATABFAF8AVABFAFgAQwBVAEIARQBfAEwATwBEACgAdQBuAGkAdAB5AF8AUwBwAGUAYwBDAHUAYgBlADAALAAgAFYAUgAsACAAbQBpAHAAKQA7AAoAcgBlAHQAdQByAG4AIABEAGUAYwBvAGQAZQBIAEQAUgAgACgAcwBrAHkARABhAHQAYQAsACAAdQBuAGkAdAB5AF8AUwBwAGUAYwBDAHUAYgBlADAAXwBIAEQAUgApADsA,output:2,fname:Code_ReflectionProbe,width:541,height:132,input:2,input:2,input_1_label:VR,input_2_label:mip|A-4417-OUT,B-6573-OUT;n:type:ShaderForge.SFN_ViewReflectionVector,id:4417,x:28848,y:34793,varname:node_4417,prsc:2;n:type:ShaderForge.SFN_Slider,id:9147,x:28650,y:34993,ptovrint:False,ptlb:[Reflection] Roughness,ptin:_ReflectionRoughness,varname:node_9147,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Code,id:3902,x:29234,y:35009,varname:node_3902,prsc:2,code:ZgBsAG8AYQB0ADQAIABzAGsAeQBEAGEAdABhACAAPQAgAFUATgBJAFQAWQBfAFMAQQBNAFAATABFAF8AVABFAFgAQwBVAEIARQBfAFMAQQBNAFAATABFAFIAXwBMAE8ARAAoAHUAbgBpAHQAeQBfAFMAcABlAGMAQwB1AGIAZQAxACwAIAB1AG4AaQB0AHkAXwBTAHAAZQBjAEMAdQBiAGUAMAAsACAAVgBSACwAIABtAGkAcAApADsACgByAGUAdAB1AHIAbgAgAEQAZQBjAG8AZABlAEgARABSACAAKABzAGsAeQBEAGEAdABhACwAIAB1AG4AaQB0AHkAXwBTAHAAZQBjAEMAdQBiAGUAMABfAEgARABSACkAOwA=,output:2,fname:Code_ReflectionProbe2,width:740,height:132,input:2,input:2,input_1_label:VR,input_2_label:mip|A-4417-OUT,B-6573-OUT;n:type:ShaderForge.SFN_Lerp,id:6081,x:30272,y:35126,varname:node_6081,prsc:2|A-3902-OUT,B-12-OUT,T-3794-OUT;n:type:ShaderForge.SFN_Code,id:3794,x:29197,y:35179,varname:node_3794,prsc:2,code:cgBlAHQAdQByAG4AIAB1AG4AaQB0AHkAXwBTAHAAZQBjAEMAdQBiAGUAMABfAEIAbwB4AE0AaQBuAC4AdwA7AA==,output:0,fname:ReflectionProbeBlendingValue,width:451,height:112;n:type:ShaderForge.SFN_Set,id:6742,x:30352,y:35027,varname:ReflectionProbe,prsc:2|IN-6081-OUT;n:type:ShaderForge.SFN_Tex2d,id:6892,x:28682,y:35152,ptovrint:False,ptlb:[Reflection] Roughness map,ptin:_ReflectionRoughnessmap,varname:node_6892,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6573,x:28987,y:35055,varname:node_6573,prsc:2|A-9147-OUT,B-6892-RGB,C-4130-OUT;n:type:ShaderForge.SFN_Vector1,id:4130,x:28696,y:35332,varname:node_4130,prsc:2,v1:14;n:type:ShaderForge.SFN_RemapRange,id:7572,x:28505,y:30645,varname:node_7572,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8025-OUT;n:type:ShaderForge.SFN_Set,id:8997,x:29649,y:30869,varname:matcap,prsc:2|IN-7200-OUT;n:type:ShaderForge.SFN_Get,id:4023,x:33651,y:32402,varname:node_4023,prsc:2|IN-8997-OUT;n:type:ShaderForge.SFN_Get,id:9547,x:32913,y:32603,varname:node_9547,prsc:2|IN-147-OUT;n:type:ShaderForge.SFN_Set,id:4973,x:31983,y:31865,varname:ToonedMap,prsc:2|IN-5493-OUT;n:type:ShaderForge.SFN_Get,id:6246,x:32892,y:32460,varname:node_6246,prsc:2|IN-4973-OUT;n:type:ShaderForge.SFN_Slider,id:755,x:32453,y:32362,ptovrint:False,ptlb:[Reflection] Reflection Power,ptin:_ReflectionReflectionPower,varname:node_755,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:7936,x:32610,y:32460,ptovrint:False,ptlb:[Reflection] Reflection Mask,ptin:_ReflectionReflectionMask,varname:node_7936,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Max,id:3205,x:33644,y:32755,varname:node_3205,prsc:2|A-5404-OUT,B-7260-OUT;n:type:ShaderForge.SFN_Slider,id:9118,x:32116,y:35066,ptovrint:False,ptlb:[Gloss] Blend,ptin:_GlossBlend,varname:node_9118,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Set,id:6538,x:32724,y:35165,varname:Gloss,prsc:2|IN-5085-OUT;n:type:ShaderForge.SFN_Get,id:7260,x:33288,y:32849,varname:node_7260,prsc:2|IN-6538-OUT;n:type:ShaderForge.SFN_Fresnel,id:2986,x:31385,y:33852,varname:node_2986,prsc:2|EXP-9320-OUT;n:type:ShaderForge.SFN_Slider,id:9320,x:30918,y:34042,ptovrint:False,ptlb:[Rim] Fresnel Power,ptin:_RimFresnelPower,varname:node_9320,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Max,id:1817,x:34244,y:33044,varname:node_1817,prsc:2|A-6025-OUT,B-5268-OUT;n:type:ShaderForge.SFN_Color,id:134,x:31113,y:33844,ptovrint:False,ptlb:[Rim] Color,ptin:_RimColor,varname:node_134,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_SwitchProperty,id:798,x:31278,y:33620,ptovrint:False,ptlb:[Rim] Use Base Texture,ptin:_RimUseBaseTexture,varname:node_798,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-118-RGB,B-9323-OUT;n:type:ShaderForge.SFN_Get,id:9323,x:31044,y:33775,varname:node_9323,prsc:2|IN-5118-OUT;n:type:ShaderForge.SFN_Multiply,id:6937,x:31541,y:33628,varname:node_6937,prsc:2|A-798-OUT,B-2986-OUT,C-6608-OUT,D-134-RGB;n:type:ShaderForge.SFN_Slider,id:6608,x:30708,y:33912,ptovrint:False,ptlb:[Rim] Blend,ptin:_RimBlend,varname:node_6608,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:3;n:type:ShaderForge.SFN_Tex2d,id:118,x:31044,y:33603,ptovrint:False,ptlb:[Rim] Texture,ptin:_RimTexture,varname:node_118,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Set,id:5575,x:31786,y:33694,varname:RimLight,prsc:2|IN-6937-OUT;n:type:ShaderForge.SFN_Get,id:5268,x:33886,y:33028,varname:node_5268,prsc:2|IN-5575-OUT;n:type:ShaderForge.SFN_SwitchProperty,id:117,x:31663,y:31038,ptovrint:False,ptlb:[Shadow Plan B] Use Custom Shadow Texture,ptin:_ShadowPlanBUseCustomShadowTexture,varname:node_117,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2493-OUT,B-5331-RGB;n:type:ShaderForge.SFN_Tex2d,id:5331,x:31419,y:31021,ptovrint:False,ptlb:[Shadow Plan B] Custom Shadow Texture,ptin:_ShadowPlanBCustomShadowTexture,varname:node_5331,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:2,isnm:False;n:type:ShaderForge.SFN_Color,id:1051,x:28831,y:30331,ptovrint:False,ptlb:[Matcap] Color,ptin:_MatcapColor,varname:node_1051,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:1248,x:29108,y:30332,varname:node_1248,prsc:2|A-1051-RGB,B-3315-RGB;n:type:ShaderForge.SFN_Get,id:6600,x:32347,y:32066,varname:node_6600,prsc:2|IN-6742-OUT;n:type:ShaderForge.SFN_Set,id:147,x:33246,y:32233,varname:ReflectionMap,prsc:2|IN-9475-OUT;n:type:ShaderForge.SFN_Multiply,id:9475,x:32984,y:32236,varname:node_9475,prsc:2|A-755-OUT,B-7936-RGB,C-7583-OUT;n:type:ShaderForge.SFN_Add,id:5404,x:33300,y:32500,varname:node_5404,prsc:2|A-6246-OUT,B-9547-OUT;n:type:ShaderForge.SFN_Cubemap,id:8280,x:32512,y:31903,ptovrint:False,ptlb:[Reflection] Cubemap,ptin:_ReflectionCubemap,varname:node_8280,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0;n:type:ShaderForge.SFN_Lerp,id:7583,x:32913,y:31952,varname:node_7583,prsc:2|A-6600-OUT,B-8280-RGB,T-6702-OUT;n:type:ShaderForge.SFN_Slider,id:6702,x:32293,y:32135,ptovrint:False,ptlb:[Reflection] Cubemap Mix,ptin:_ReflectionCubemapMix,varname:node_6702,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:1;n:type:ShaderForge.SFN_Tex2d,id:296,x:28665,y:30996,ptovrint:False,ptlb:[ShadowCap] Texture,ptin:_ShadowCapTexture,varname:node_296,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False|UVIN-7572-OUT;n:type:ShaderForge.SFN_Set,id:3267,x:29524,y:31297,varname:shadowcap,prsc:2|IN-3804-OUT;n:type:ShaderForge.SFN_Multiply,id:4218,x:29223,y:31054,varname:node_4218,prsc:2|A-7883-OUT,B-2734-RGB;n:type:ShaderForge.SFN_Tex2d,id:2734,x:29062,y:31282,ptovrint:False,ptlb:[ShadowCap] Mask,ptin:_ShadowCapMask,varname:_ShadowCapTexture_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_OneMinus,id:7883,x:29025,y:30998,varname:node_7883,prsc:2|IN-5526-OUT;n:type:ShaderForge.SFN_OneMinus,id:3804,x:29428,y:31074,varname:node_3804,prsc:2|IN-4218-OUT;n:type:ShaderForge.SFN_Color,id:9239,x:28643,y:31251,ptovrint:False,ptlb:[ShadowCap] Color,ptin:_ShadowCapColor,varname:node_9239,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:5526,x:28854,y:31059,varname:node_5526,prsc:2|A-296-RGB,B-9239-RGB;n:type:ShaderForge.SFN_Min,id:7257,x:33619,y:33009,varname:node_7257,prsc:2|A-3205-OUT,B-2250-OUT;n:type:ShaderForge.SFN_Get,id:2250,x:33326,y:33185,varname:node_2250,prsc:2|IN-3267-OUT;proporder:851-5927-7164-4574-6817-9118-5328-4865-1674-6003-3825-1966-4550-2836-1972-5493-8331-9586-4873-117-5331-5498-3315-1051-3008-755-7936-8280-6702-9147-6892-6608-9320-134-118-798-296-2734-9239;pass:END;sub:END;*/

Shader "arktoon/Fade" {
    Properties {
        // Culling,ZWrite         
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull", Float) = 2
        [Enum(Off, 0, On, 1)]_ZWrite("ZWrite", Float) = 0

        // Common
        _BaseTexture ("Base Texture", 2D) = "white" {}
        _BaseColor ("Base Color", Color) = (1,1,1,1)
        _Normalmap ("Normal map", 2D) = "bump" {}
        _Emissionmap ("Emission map", 2D) = "white" {}
        _EmissionColor ("Emission Color", Color) = (0,0,0,1)
        // Shadow
        _ShadowBoarderMin ("Boarder Min", Range(0, 1)) = 0.499
        _ShadowBoarderMax ("Boarder Max", Range(0, 1)) = 0.55
        _ShadowStrength ("Strength", Range(0, 1)) = 0.5
        // Plan B
        [MaterialToggle] _ShadowPlanBUsePlanB ("[Plan B] Use Plan B", Float ) = 0
        _ShadowPlanBHueShiftFromBase ("[Plan B] Hue Shift From Base", Range(-1, 1)) = 0
        _ShadowPlanBSaturationFromBase ("[Plan B] Saturation From Base", Range(0, 2)) = 1
        _ShadowPlanBValueFromBase ("[Plan B] Value From Base", Range(0, 2)) = 0        
        [MaterialToggle] _ShadowPlanBUseCustomShadowTexture ("[Plan B] Use Custom Shadow Texture", Float ) = 0
        _ShadowPlanBCustomShadowTexture ("[Plan B] Custom Shadow Texture", 2D) = "black" {}
        // Gloss
        [Toggle(USE_GLOSS)]_UseGloss ("Enabled", Float) = 0
        _GlossBlend ("Blend", Range(0, 1)) = 0
        _GlossPower ("Power", Range(0, 1)) = 0.5
        _GlossColor ("Color", Color) = (1,1,1,1)
        // MatCap
        [Toggle(USE_MATCAP)]_UseMatcap ("Enabled", Float) = 0
        _MatcapBoost ("Boost", Range(0, 2)) = 1
        _MatcapTexture ("Texture", 2D) = "black" {}
        _MatcapColor ("Color", Color) = (1,1,1,1)
        _MatcapMask ("Mask", 2D) = "white" {}
        // Reflection
        [Toggle(USE_REFLECTION)]_UseReflection ("Enabled", Float) = 0
        _ReflectionReflectionPower ("Reflection Power", Range(0, 1)) = 0
        _ReflectionReflectionMask ("Reflection Mask", 2D) = "white" {}
        _ReflectionCubemap ("Cubemap", Cube) = "_Skybox" {}
        _ReflectionCubemapMix ("Cubemap Mix", Range(0, 1)) = 0
        _ReflectionRoughness ("Roughness", Range(0, 1)) = 0
        _ReflectionRoughnessmap ("Roughness map", 2D) = "white" {}
        // Rim
        [Toggle(USE_RIM)]_UseRim ("Enabled", Float) = 0
        _RimBlend ("Blend", Range(0, 3)) = 0
        _RimFresnelPower ("Fresnel Power", Range(0, 10)) = 1
        _RimColor ("Color", Color) = (1,1,1,1)
        _RimTexture ("Texture", 2D) = "white" {}
        [MaterialToggle] _RimUseBaseTexture ("Use Base Texture", Float ) = 0
        // ShadowCap
        [Toggle(USE_SHADOWCAP)]_UseShadowCap ("Enabled", Float) = 0
        _ShadowCapTexture ("Texture", 2D) = "white" {}
        _ShadowCapMask ("Mask", 2D) = "white" {}
        _ShadowCapColor ("Color", Color) = (1,1,1,1)
    }
    SubShader {
        Tags {
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull [_Cull]
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite [_ZWrite]
            
            CGPROGRAM
            #pragma shader_feature USE_GLOSS
            #pragma shader_feature USE_MATCAP   
            #pragma shader_feature USE_REFLECTION
            #pragma shader_feature USE_RIM
            #pragma shader_feature USE_SHADOWCAP
            
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _BaseTexture; uniform float4 _BaseTexture_ST;
            uniform float4 _BaseColor;
            uniform float _GlossPower;
            uniform float4 _GlossColor;
            float3 ShadeSH9Indirect(){
            return ShadeSH9(half4(0.0, -1.0, 0.0, 1.0));
            
            }
            
            float3 ShadeSH9Direct(){
            return ShadeSH9(half4(0.0, 1.0, 0.0, 1.0));
            
            }
            
            float3 grayscale_vector_node(){
            
return float3(0, 0.3823529, 0.01845836);
            }
            
            float3 Function_node_4132( float3 normalDirection ){
            return ShadeSH9(half4(normalDirection, 1.0));
            }
            
            uniform float _ShadowPlanBHueShiftFromBase;
            uniform float _ShadowPlanBSaturationFromBase;
            uniform float _ShadowPlanBValueFromBase;
            uniform fixed _ShadowPlanBUsePlanB;
            uniform float _ShadowBoarderMin;
            uniform float _ShadowBoarderMax;
            uniform float _ShadowStrength;
            uniform sampler2D _Normalmap; uniform float4 _Normalmap_ST;
            uniform sampler2D _Emissionmap; uniform float4 _Emissionmap_ST;
            uniform float4 _EmissionColor;
            uniform sampler2D _MatcapTexture; uniform float4 _MatcapTexture_ST;
            uniform float _MatcapBoost;
            uniform sampler2D _MatcapMask; uniform float4 _MatcapMask_ST;
            float3 Code_ReflectionProbe( float3 VR , float3 mip ){
            float4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, VR, mip);
            return DecodeHDR (skyData, unity_SpecCube0_HDR);
            }
            
            uniform float _ReflectionRoughness;
            float3 Code_ReflectionProbe2( float3 VR , float3 mip ){
            float4 skyData = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, VR, mip);
            return DecodeHDR (skyData, unity_SpecCube0_HDR);
            }
            
            float ReflectionProbeBlendingValue(){
            return unity_SpecCube0_BoxMin.w;
            }
            
            uniform sampler2D _ReflectionRoughnessmap; uniform float4 _ReflectionRoughnessmap_ST;
            uniform float _ReflectionReflectionPower;
            uniform sampler2D _ReflectionReflectionMask; uniform float4 _ReflectionReflectionMask_ST;
            uniform float _GlossBlend;
            uniform float _RimFresnelPower;
            uniform float4 _RimColor;
            uniform fixed _RimUseBaseTexture;
            uniform float _RimBlend;
            uniform sampler2D _RimTexture; uniform float4 _RimTexture_ST;
            uniform fixed _ShadowPlanBUseCustomShadowTexture;
            uniform sampler2D _ShadowPlanBCustomShadowTexture; uniform float4 _ShadowPlanBCustomShadowTexture_ST;
            uniform float4 _MatcapColor;
            uniform samplerCUBE _ReflectionCubemap;
            uniform float _ReflectionCubemapMix;
            uniform sampler2D _ShadowCapTexture; uniform float4 _ShadowCapTexture_ST;
            uniform sampler2D _ShadowCapMask; uniform float4 _ShadowCapMask_ST;
            uniform float4 _ShadowCapColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normalmap_var = UnpackNormal(tex2D(_Normalmap,TRANSFORM_TEX(i.uv0, _Normalmap)));
                float3 normalLocal = _Normalmap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:
                float4 _Emissionmap_var = tex2D(_Emissionmap,TRANSFORM_TEX(i.uv0, _Emissionmap));
                float2 node_7572 = (mul( UNITY_MATRIX_V, float4(normalDirection,0) ).xyz.rgb.rg*0.5+0.5);
                #ifdef USE_MATCAP
                    float4 _MatcapTexture_var = tex2D(_MatcapTexture,TRANSFORM_TEX(node_7572, _MatcapTexture));
                    float4 _MatcapMask_var = tex2D(_MatcapMask,TRANSFORM_TEX(i.uv0, _MatcapMask));
                    float3 matcap = ((_MatcapColor.rgb*_MatcapTexture_var.rgb)*_MatcapMask_var.rgb*_MatcapBoost);
                #else
                    float3 matcap = float3(0,0,0);
                #endif

                float4 _BaseTexture_var = tex2D(_BaseTexture,TRANSFORM_TEX(i.uv0, _BaseTexture));
                float3 Diffuse = (_BaseTexture_var.rgb*_BaseColor.rgb);

                #ifdef USE_RIM
                    float4 _RimTexture_var = tex2D(_RimTexture,TRANSFORM_TEX(i.uv0, _RimTexture));
                    float3 RimLight = (lerp( _RimTexture_var.rgb, Diffuse, _RimUseBaseTexture )*pow(1.0-max(0,dot(normalDirection, viewDirection)),_RimFresnelPower)*_RimBlend*_RimColor.rgb);
                #else
                    float3 RimLight = float3(0,0,0);
                #endif

                float3 emissive = max(((_Emissionmap_var.rgb*_EmissionColor.rgb)+matcap),RimLight);
                float3 ShadeSH9Minus = ShadeSH9Indirect();
                float3 indirectLighting = saturate(ShadeSH9Minus);
                float3 ShadeSH9Plus = ShadeSH9Direct();
                float3 directLighting = saturate((ShadeSH9Plus+_LightColor0.rgb));
                float3 grayscale_vector = grayscale_vector_node();
                float grayscalelightcolor = dot(_LightColor0.rgb,grayscale_vector);
                float grayscaleDirectLighting = ((dot(lightDirection,normalDirection)*grayscalelightcolor*attenuation)+dot(Function_node_4132( normalDirection ),grayscale_vector));
                float bottomIndirectLighting = dot(ShadeSH9Minus,grayscale_vector);
                float topIndirectLighting = dot(ShadeSH9Plus,grayscale_vector);
                float lightDifference = ((topIndirectLighting+grayscalelightcolor)-bottomIndirectLighting);
                float remappedLight = ((grayscaleDirectLighting-bottomIndirectLighting)/lightDifference);
                float node_4614 = 0.0;
                float directContribution = (1.0 - ((1.0 - saturate((node_4614 + ( (saturate(remappedLight) - _ShadowBoarderMin) * (1.0 - node_4614) ) / (_ShadowBoarderMax - _ShadowBoarderMin))))*_ShadowStrength));
                float3 node_4133 = lerp(indirectLighting,directLighting,directContribution);
                float3 node_1346 = Diffuse;
                float4 node_5443_k = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 node_5443_p = lerp(float4(float4(node_1346,0.0).zy, node_5443_k.wz), float4(float4(node_1346,0.0).yz, node_5443_k.xy), step(float4(node_1346,0.0).z, float4(node_1346,0.0).y));
                float4 node_5443_q = lerp(float4(node_5443_p.xyw, float4(node_1346,0.0).x), float4(float4(node_1346,0.0).x, node_5443_p.yzx), step(node_5443_p.x, float4(node_1346,0.0).x));
                float node_5443_d = node_5443_q.x - min(node_5443_q.w, node_5443_q.y);
                float node_5443_e = 1.0e-10;
                float3 node_5443 = float3(abs(node_5443_q.z + (node_5443_q.w - node_5443_q.y) / (6.0 * node_5443_d + node_5443_e)), node_5443_d / (node_5443_q.x + node_5443_e), node_5443_q.x);;
                float3 Diff_HSV = (lerp(float3(1,1,1),saturate(3.0*abs(1.0-2.0*frac((_ShadowPlanBHueShiftFromBase+node_5443.r)+float3(0.0,-1.0/3.0,1.0/3.0)))-1),(node_5443.g*_ShadowPlanBSaturationFromBase))*(_ShadowPlanBValueFromBase*node_5443.b));
                float4 _ShadowPlanBCustomShadowTexture_var = tex2D(_ShadowPlanBCustomShadowTexture,TRANSFORM_TEX(i.uv0, _ShadowPlanBCustomShadowTexture));
                float3 ToonedMap = lerp( (Diffuse*node_4133), (lerp(lerp( Diff_HSV, _ShadowPlanBCustomShadowTexture_var.rgb, _ShadowPlanBUseCustomShadowTexture ),Diffuse,node_4133)/1.0), _ShadowPlanBUsePlanB );

                #ifdef USE_REFLECTION
                    float4 _ReflectionReflectionMask_var = tex2D(_ReflectionReflectionMask,TRANSFORM_TEX(i.uv0, _ReflectionReflectionMask));
                    float4 _ReflectionRoughnessmap_var = tex2D(_ReflectionRoughnessmap,TRANSFORM_TEX(i.uv0, _ReflectionRoughnessmap));
                    float3 node_6573 = (_ReflectionRoughness*_ReflectionRoughnessmap_var.rgb*14.0);
                    float3 ReflectionProbe = lerp(Code_ReflectionProbe2( viewReflectDirection , node_6573 ),Code_ReflectionProbe( viewReflectDirection , node_6573 ),ReflectionProbeBlendingValue());
                    float3 ReflectionMap = (_ReflectionReflectionPower*_ReflectionReflectionMask_var.rgb*lerp(ReflectionProbe,texCUBElod(_ReflectionCubemap,float4(viewReflectDirection,_ReflectionRoughness*15.0)).rgb,_ReflectionCubemapMix));
                #else
                    float3 ReflectionMap = float3(0,0,0);
                #endif

                #ifdef USE_GLOSS
                    float3 Gloss = ((max(0,dot(lightDirection,normalDirection))*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_GlossPower)))*_GlossColor.rgb)*_LightColor0.rgb*attenuation*_GlossBlend);
                #else
                    float3 Gloss = float3(0,0,0);
                #endif

                #ifdef USE_SHADOWCAP
                    float4 _ShadowCapTexture_var = tex2D(_ShadowCapTexture,TRANSFORM_TEX(node_7572, _ShadowCapTexture));
                    float4 _ShadowCapMask_var = tex2D(_ShadowCapMask,TRANSFORM_TEX(i.uv0, _ShadowCapMask));
                    float3 shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb*_ShadowCapColor.rgb))*_ShadowCapMask_var.rgb));
                #else
                    float3 shadowcap = float3(1000,1000,1000);
                #endif                

                float3 finalColor = emissive + min(max((ToonedMap+ReflectionMap),Gloss),shadowcap);
                fixed4 finalRGBA = fixed4(finalColor,(_BaseTexture_var.a*_BaseColor.a));
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Cull [_Cull]
            Blend One One
            ZWrite [_ZWrite]
            
            CGPROGRAM
            #pragma shader_feature USE_GLOSS
            #pragma shader_feature USE_SHADOWCAP
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles 
            #pragma target 3.0
            uniform sampler2D _BaseTexture; uniform float4 _BaseTexture_ST;
            uniform float4 _BaseColor;
            uniform float _GlossPower;
            uniform float4 _GlossColor;
            float3 ShadeSH9Indirect(){
            return ShadeSH9(half4(0.0, -1.0, 0.0, 1.0));
            
            }
            
            float3 ShadeSH9Direct(){
            return ShadeSH9(half4(0.0, 1.0, 0.0, 1.0));
            
            }
            
            float3 grayscale_vector_node(){
            
return float3(0, 0.3823529, 0.01845836);
            }
            
            float3 Function_node_4132( float3 normalDirection ){
            return ShadeSH9(half4(normalDirection, 1.0));
            }
            
            uniform float _ShadowPlanBHueShiftFromBase;
            uniform float _ShadowPlanBSaturationFromBase;
            uniform float _ShadowPlanBValueFromBase;
            uniform fixed _ShadowPlanBUsePlanB;
            uniform float _ShadowBoarderMin;
            uniform float _ShadowBoarderMax;
            uniform float _ShadowStrength;
            uniform sampler2D _Normalmap; uniform float4 _Normalmap_ST;
            uniform sampler2D _Emissionmap; uniform float4 _Emissionmap_ST;
            uniform float4 _EmissionColor;
            float3 Code_ReflectionProbe( float3 VR , float3 mip ){
            float4 skyData = UNITY_SAMPLE_TEXCUBE_LOD(unity_SpecCube0, VR, mip);
            return DecodeHDR (skyData, unity_SpecCube0_HDR);
            }
            
            uniform float _ReflectionRoughness;
            float3 Code_ReflectionProbe2( float3 VR , float3 mip ){
            float4 skyData = UNITY_SAMPLE_TEXCUBE_SAMPLER_LOD(unity_SpecCube1, unity_SpecCube0, VR, mip);
            return DecodeHDR (skyData, unity_SpecCube0_HDR);
            }
            
            float ReflectionProbeBlendingValue(){
            return unity_SpecCube0_BoxMin.w;
            }
            
            uniform float _GlossBlend;
            uniform sampler2D _ShadowCapTexture; uniform float4 _ShadowCapTexture_ST;
            uniform sampler2D _ShadowCapMask; uniform float4 _ShadowCapMask_ST;
            uniform float4 _ShadowCapColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
                LIGHTING_COORDS(5,6)
                UNITY_FOG_COORDS(7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                float3 lightColor = _LightColor0.rgb;
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _Normalmap_var = UnpackNormal(tex2D(_Normalmap,TRANSFORM_TEX(i.uv0, _Normalmap)));
                float3 normalLocal = _Normalmap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);

                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _BaseTexture_var = tex2D(_BaseTexture,TRANSFORM_TEX(i.uv0, _BaseTexture));
                float3 Diffuse = (_BaseTexture_var.rgb*_BaseColor.rgb);
                
				float lightContribution = dot(normalize(_WorldSpaceLightPos0.xyz - i.posWorld.xyz),normalDirection)*attenuation;
                float3 directContribution = (1.0 - (1.0 - saturate(((saturate(lightContribution) - _ShadowBoarderMin) / (_ShadowBoarderMax - _ShadowBoarderMin)))));
                float3 finalLight = saturate(directContribution + ((1 - _ShadowStrength) * attenuation));
                float3 ToonedMap = Diffuse * lerp(0, _LightColor0.rgb, finalLight);
                #ifdef USE_GLOSS
                    float3 Gloss = ((max(0,dot(lightDirection,normalDirection))*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_GlossPower)))*_GlossColor.rgb)*_LightColor0.rgb*attenuation*_GlossBlend);
                #else
                    float3 Gloss = float3(0,0,0);
                #endif                    
                float2 node_7572 = (mul( UNITY_MATRIX_V, float4(normalDirection,0) ).xyz.rgb.rg*0.5+0.5);


                #ifdef USE_SHADOWCAP
                    float4 _ShadowCapTexture_var = tex2D(_ShadowCapTexture,TRANSFORM_TEX(node_7572, _ShadowCapTexture));
                    float4 _ShadowCapMask_var = tex2D(_ShadowCapMask,TRANSFORM_TEX(i.uv0, _ShadowCapMask));
                    float3 shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb*_ShadowCapColor.rgb))*_ShadowCapMask_var.rgb));
                #else
                    float3 shadowcap = float3(1000,1000,1000);
                #endif  


                float3 finalColor = min(max((ToonedMap),Gloss),shadowcap);

                fixed4 finalRGBA = fixed4(finalColor * (_BaseTexture_var.a * _BaseColor.a),0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }
    }
    FallBack "Standard"
    CustomEditor "ArktoonShaders.ArktoonInspector"
}
