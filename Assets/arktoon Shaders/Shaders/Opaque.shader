// Copyright (c) 2018 synqark
//
// This code and repos（https://github.com/synqark/Arktoon-Shader) is under MIT licence, see LICENSE
//
// 本コードおよびリポジトリ（https://github.com/synqark/Arktoon-Shader) は MIT License を使用して公開しています。
// 詳細はLICENSEか、https://opensource.org/licenses/mit-license.php を参照してください。
Shader "arktoon/Opaque" {
    Properties {
        // Culling
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull", Float) = 2 // Back
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
        _ShadowStrengthMask ("Strength Mask", 2D) = "white" {}
        // Plan B
        [Toggle(USE_SHADE_TEXTURE)]_ShadowPlanBUsePlanB ("[Plan B] Use Plan B", Float ) = 0
        [Toggle(USE_SHADOW_MIX)]_ShadowPlanBUseShadowMix ("[Plan B] Use Shadow Mix", Float ) = 0
        _ShadowPlanBHueShiftFromBase ("[Plan B] Hue Shift From Base", Range(-1, 1)) = 0
        _ShadowPlanBSaturationFromBase ("[Plan B] Saturation From Base", Range(0, 2)) = 1
        _ShadowPlanBValueFromBase ("[Plan B] Value From Base", Range(0, 2)) = 0
        [MaterialToggle] _ShadowPlanBUseCustomShadowTexture ("[Plan B] Use Custom Shadow Texture", Float ) = 0
        _ShadowPlanBCustomShadowTexture ("[Plan B] Custom Shadow Texture", 2D) = "black" {}
        _ShadowPlanBCustomShadowTextureRGB ("[Plan B] Custom Shadow Texture RGB", Color) = (1,1,1,1)
        // Gloss
        [Toggle(USE_GLOSS)]_UseGloss ("Enabled", Float) = 0
        _GlossBlend ("Blend", Range(0, 1)) = 0
        _GlossPower ("Power", Range(0, 1)) = 0.5
        _GlossColor ("Color", Color) = (1,1,1,1)
        // Outline
        [Toggle(USE_OUTLINE)]_UseOutline ("Enabled", Float) = 0
        _OutlineWidth ("Width", Range(0, 0.03)) = 0.0005
        _OutlineWidthMask ("Width Mask", 2D) = "white" {}
        _OutlineColor ("Color", Color) = (0,0,0,1)
        _OutlineTextureColorRate ("Texture Color Rate", Range(0, 1)) = 0.05
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
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            Cull [_Cull]

            CGPROGRAM
            #pragma shader_feature USE_SHADE_TEXTURE
            #pragma shader_feature USE_SHADOW_MIX
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
            #pragma multi_compile_fwdbase_fullshadows
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
            uniform float _ShadowBoarderMin;
            uniform float _ShadowBoarderMax;
            uniform float _ShadowStrength;
            uniform sampler2D _ShadowStrengthMask; uniform float4 _ShadowStrengthMask_ST;
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
            uniform float4 _ShadowPlanBCustomShadowTextureRGB;
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
                float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));
                float directContribution = (1.0 - ((1.0 - saturate((node_4614 + ( (saturate(remappedLight) - _ShadowBoarderMin) * (1.0 - node_4614) ) / (_ShadowBoarderMax - _ShadowBoarderMin)))) * _ShadowStrengthMask_var * _ShadowStrength));
                float3 finalLight = lerp(indirectLighting,directLighting,directContribution);
                float3 node_1346 = Diffuse;
                float4 node_5443_k = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
                float4 node_5443_p = lerp(float4(float4(node_1346,0.0).zy, node_5443_k.wz), float4(float4(node_1346,0.0).yz, node_5443_k.xy), step(float4(node_1346,0.0).z, float4(node_1346,0.0).y));
                float4 node_5443_q = lerp(float4(node_5443_p.xyw, float4(node_1346,0.0).x), float4(float4(node_1346,0.0).x, node_5443_p.yzx), step(node_5443_p.x, float4(node_1346,0.0).x));
                float node_5443_d = node_5443_q.x - min(node_5443_q.w, node_5443_q.y);
                float node_5443_e = 1.0e-10;
                float3 node_5443 = float3(abs(node_5443_q.z + (node_5443_q.w - node_5443_q.y) / (6.0 * node_5443_d + node_5443_e)), node_5443_d / (node_5443_q.x + node_5443_e), node_5443_q.x);;
                float3 Diff_HSV = (lerp(float3(1,1,1),saturate(3.0*abs(1.0-2.0*frac((_ShadowPlanBHueShiftFromBase+node_5443.r)+float3(0.0,-1.0/3.0,1.0/3.0)))-1),(node_5443.g*_ShadowPlanBSaturationFromBase))*(_ShadowPlanBValueFromBase*node_5443.b));
                float4 _ShadowPlanBCustomShadowTexture_var = tex2D(_ShadowPlanBCustomShadowTexture,TRANSFORM_TEX(i.uv0, _ShadowPlanBCustomShadowTexture));
                float3 shadowCustomTexture = _ShadowPlanBCustomShadowTexture_var.rgb * _ShadowPlanBCustomShadowTextureRGB.rgb;

                #ifdef USE_SHADE_TEXTURE
                    #ifdef USE_SHADOW_MIX
                        float3 ShadeMap = lerp( Diff_HSV*finalLight, shadowCustomTexture*finalLight, _ShadowPlanBUseCustomShadowTexture );
                    #else
                        float3 ShadeMap = lerp( Diff_HSV*directLighting, shadowCustomTexture*directLighting, _ShadowPlanBUseCustomShadowTexture );
                    #endif
                    float3 ToonedMap = (lerp(ShadeMap,Diffuse*finalLight,finalLight)/1.0);
                #else
                    float3 ToonedMap = Diffuse*finalLight;
                #endif

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
                fixed4 finalRGBA = fixed4(finalColor,1);
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


            CGPROGRAM
            #pragma shader_feature USE_GLOSS
            #pragma shader_feature USE_SHADOWCAP
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
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

            uniform float _ShadowBoarderMin;
            uniform float _ShadowBoarderMax;
            uniform float _ShadowStrength;
            uniform sampler2D _ShadowStrengthMask; uniform float4 _ShadowStrengthMask_ST;
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

                float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));
                float3 finalLight = saturate(directContribution + ((1 - (_ShadowStrength * _ShadowStrengthMask_var)) * attenuation));
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

                fixed4 finalRGBA = fixed4(finalColor * 1,0);
                UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
                return finalRGBA;
            }
            ENDCG
        }

        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front

            CGPROGRAM
            #pragma shader_feature USE_OUTLINE
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0
            uniform sampler2D _BaseTexture; uniform float4 _BaseTexture_ST;
            uniform float4 _BaseColor;
            uniform float _OutlineWidth;
            uniform float _OutlineTextureColorRate;
            uniform sampler2D _OutlineWidthMask; uniform float4 _OutlineWidthMask_ST;
            uniform float4 _OutlineColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
            };
            VertexOutput vert (VertexInput v) {
                #ifdef USE_OUTLINE
                    VertexOutput o = (VertexOutput)0;
                    o.uv0 = v.texcoord0;
                    float4 _OutlineWidthMask_var = tex2Dlod(_OutlineWidthMask,float4(TRANSFORM_TEX(o.uv0, _OutlineWidthMask),0.0,0));
                    o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*(_OutlineWidth*_OutlineWidthMask_var.r),1) );
                    UNITY_TRANSFER_FOG(o,o.pos);
                    return o;
                #else
                    return (VertexOutput)0;
                #endif
            }
            float4 frag(VertexOutput i) : COLOR {
                #ifdef USE_OUTLINE
                    float4 _BaseTexture_var = tex2D(_BaseTexture,TRANSFORM_TEX(i.uv0, _BaseTexture));
                    float3 Diffuse = (_BaseTexture_var.rgb*_BaseColor.rgb);
                    return fixed4(lerp(_OutlineColor.rgb,Diffuse,_OutlineTextureColorRate),0);
                #else
                    return fixed4(0,0,0,0);
                #endif
            }
            ENDCG
        }
    }
    FallBack "Standard"
    CustomEditor "ArktoonShaders.ArktoonInspector"
}
