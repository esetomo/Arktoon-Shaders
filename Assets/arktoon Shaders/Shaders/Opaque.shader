// Copyright (c) 2018 synqark
//
// This code and repos（https://github.com/synqark/Arktoon-Shader) is under MIT licence, see LICENSE
//
// 本コードおよびリポジトリ（https://github.com/synqark/Arktoon-Shader) は MIT License を使用して公開しています。
// 詳細はLICENSEか、https://opensource.org/licenses/mit-license.php を参照してください。
Shader "arktoon/Opaque" {
    Properties {
        // Culling
        [Enum(UnityEngine.Rendering.CullMode)]_Cull("[Advanced] Cull", Float) = 2 // Back
        // test roughness map
        // _RoughnessMap ("[Common] Base Texture", 2D) = "white" {}
        // Common
        _MainTex ("[Common] Base Texture", 2D) = "white" {}
        _Color ("[Common] Base Color", Color) = (1,1,1,1)
        _BumpMap ("[Common] Normal map", 2D) = "bump" {}
        _BumpScale ("[Common] Normal scale", Range(0,2)) = 1
        _EmissionMap ("[Common] Emission map", 2D) = "white" {}
        _EmissionColor ("[Common] Emission Color", Color) = (0,0,0,1)
        // Shadow (received from DirectionalLight, other Indirect(baked) Lights, including SH)
        _ShadowborderMin ("[Shadow] border Min", Range(0, 1)) = 0.499
        _ShadowborderMax ("[Shadow] border Max", Range(0, 1)) = 0.55
        _ShadowStrength ("[Shadow] Strength", Range(0, 1)) = 0.5
        _ShadowStrengthMask ("[Shadow] Strength Mask", 2D) = "white" {}
        // Shadow steps
        [Toggle(USE_SHADOW_STEPS)]_ShadowUseStep ("[Shadow] use step", Float ) = 0
        _ShadowSteps("[Shadow] steps between borders", Range(2, 10)) = 4
        // PointShadow (received from Point/Spot Lights as Pixel/Vertex Lights)
        _PointShadowStrength ("[PointShadow] Strength", Range(0, 1)) = 0.25
        // [Toggle(USE_POINT_SHADOW_STEPS)]_PointShadowUseStep ("[Shadow] use step", Float ) = 0
        // _PointShadowSteps("[Shadow] steps between borders", Range(2, 10)) = 4
        // Plan B
        [Toggle(USE_SHADE_TEXTURE)]_ShadowPlanBUsePlanB ("[Plan B] Use Plan B", Float ) = 0
        [Toggle(USE_SHADOW_MIX)]_ShadowPlanBUseShadowMix ("[Plan B] Use Shadow Mix", Float ) = 0
        [Toggle(USE_CUSTOM_SHADOW_TEXTURE)] _ShadowPlanBUseCustomShadowTexture ("[Plan B] Use Custom Shadow Texture", Float ) = 0
        _ShadowPlanBHueShiftFromBase ("[Plan B] Hue Shift From Base", Range(-1, 1)) = 0
        _ShadowPlanBSaturationFromBase ("[Plan B] Saturation From Base", Range(0, 2)) = 1
        _ShadowPlanBValueFromBase ("[Plan B] Value From Base", Range(0, 2)) = 1
        _ShadowPlanBCustomShadowTexture ("[Plan B] Custom Shadow Texture", 2D) = "black" {}
        _ShadowPlanBCustomShadowTextureRGB ("[Plan B] Custom Shadow Texture RGB", Color) = (1,1,1,1)
        // Gloss
        [Toggle(USE_GLOSS)]_UseGloss ("[Gloss] Enabled", Float) = 0
        _GlossBlend ("[Gloss] Blend", Range(0, 1)) = 1
        _GlossBlendMask ("[Gloss] Blend Mask", 2D) = "white" {}
        _GlossPower ("[Gloss] Power", Range(0, 1)) = 0.5
        _GlossColor ("[Gloss] Color", Color) = (1,1,1,1)
        // Outline
        [Toggle(USE_OUTLINE)]_UseOutline ("[Outline] Enabled", Float) = 0
        _OutlineWidth ("[Outline] Width", Range(0, 0.03)) = 0.0005
        _OutlineWidthMask ("[Outline] Width Mask", 2D) = "white" {}
        _OutlineColor ("[Outline] Color", Color) = (0,0,0,1)
        _OutlineTextureColorRate ("[Outline] Texture Color Rate", Range(0, 1)) = 0.05
        // MatCap
        [Toggle(USE_MATCAP)]_UseMatcap ("[MatCap] Enabled", Float) = 0
        _MatcapBlend ("[MatCap] Blend", Range(0, 3)) = 1
        _MatcapBlendMask ("[MatCap] Blend Mask", 2D) = "white" {}
        _MatcapNormalMix ("[MatCap] Normal map mix", Range(0, 2)) = 1
        _MatcapShadeMix ("[MatCap] Shade Mix", Range(0, 1)) = 0
        _MatcapTexture ("[MatCap] Texture", 2D) = "black" {}
        _MatcapColor ("[MatCap] Color", Color) = (1,1,1,1)
        // Reflection
        [Toggle(USE_REFLECTION)]_UseReflection ("[Reflection] Enabled", Float) = 0
        _ReflectionReflectionPower ("[Reflection] Reflection Power", Range(0, 1)) = 1
        _ReflectionReflectionMask ("[Reflection] Reflection Mask", 2D) = "white" {}
        _ReflectionNormalMix ("[Reflection] Normal Map Mix", Range(0,2)) = 1
        _ReflectionShadeMix ("[Reflection] Shade Mix", Range(0, 1)) = 0
        _ReflectionCubemap ("[Reflection] Cubemap", Cube) = "_Skybox" {}
        _ReflectionRoughness ("[Reflection] Roughness", Range(0, 1)) = 0
        // Rim
        [Toggle(USE_RIM)]_UseRim ("[Rim] Enabled", Float) = 0
        _RimBlend ("[Rim] Blend", Range(0, 3)) = 1
        _RimBlendMask ("[Rim] Blend Mask", 2D) = "white" {}
        _RimShadeMix("[Rim] Shade Mix", Range(0, 1)) = 0
        _RimFresnelPower ("[Rim] Fresnel Power", Range(0, 10)) = 1
        _RimColor ("[Rim] Color", Color) = (1,1,1,1)
        _RimTexture ("[Rim] Texture", 2D) = "white" {}
        [MaterialToggle] _RimUseBaseTexture ("[Rim] Use Base Texture", Float ) = 0
        // ShadowCap
        [Toggle(USE_SHADOWCAP)]_UseShadowCap ("[ShadowCap] Enabled", Float) = 0
        _ShadowCapBlend ("[ShadowCap] Blend", Range(0, 3)) = 1
        _ShadowCapBlendMask ("[ShadowCap] Blend Mask", 2D) = "white" {}
        _ShadowCapNormalMix ("[ShadowCap] Normal map mix", Range(0, 2)) = 1
        _ShadowCapTexture ("[ShadowCap] Texture", 2D) = "white" {}
        _ShadowCapColor ("[ShadowCap] Color", Color) = (1,1,1,1)
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
            #pragma shader_feature USE_CUSTOM_SHADOW_TEXTURE
            #pragma shader_feature USE_SHADOW_STEPS

            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #include "arklude.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform float _GlossPower;
            uniform float4 _GlossColor;
            uniform float _ShadowPlanBHueShiftFromBase;
            uniform float _ShadowPlanBSaturationFromBase;
            uniform float _ShadowPlanBValueFromBase;
            uniform float _ShadowborderMin;
            uniform float _ShadowborderMax;
            uniform float _ShadowStrength;
            uniform int _ShadowSteps;
            uniform float _PointShadowStrength;
            uniform sampler2D _ShadowStrengthMask; uniform float4 _ShadowStrengthMask_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _BumpScale;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float4 _EmissionColor;
            uniform sampler2D _MatcapTexture; uniform float4 _MatcapTexture_ST;
            uniform float _MatcapBlend;
            uniform sampler2D _MatcapBlendMask; uniform float4 _MatcapBlendMask_ST;
            uniform float4 _MatcapColor;
            uniform float _MatcapNormalMix;
            uniform float _MatcapShadeMix;
            uniform float _ReflectionRoughness;
            uniform float _ReflectionReflectionPower;
            uniform sampler2D _ReflectionReflectionMask; uniform float4 _ReflectionReflectionMask_ST;
            uniform float _ReflectionNormalMix;
            uniform float _ReflectionShadeMix;
            uniform samplerCUBE _ReflectionCubemap;
            uniform float _GlossBlend;
            uniform sampler2D _GlossBlendMask; uniform float4 _GlossBlendMask_ST;
            uniform float _RimFresnelPower;
            uniform float4 _RimColor;
            uniform fixed _RimUseBaseTexture;
            uniform float _RimBlend;
            uniform float _RimShadeMix;
            uniform sampler2D _RimBlendMask; uniform float4 _RimBlendMask_ST;
            uniform sampler2D _RimTexture; uniform float4 _RimTexture_ST;
            uniform sampler2D _ShadowPlanBCustomShadowTexture; uniform float4 _ShadowPlanBCustomShadowTexture_ST;
            uniform float4 _ShadowPlanBCustomShadowTextureRGB;
            uniform sampler2D _ShadowCapTexture; uniform float4 _ShadowCapTexture_ST;
            uniform sampler2D _ShadowCapBlendMask; uniform float4 _ShadowCapBlendMask_ST;
            uniform float _ShadowCapBlend;
            uniform float4 _ShadowCapColor;
            uniform float _ShadowCapNormalMix;

            // vert は arklude.cginc に移動

            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackScaleNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)), _BumpScale);
                float3 normalLocal = _BumpMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz + float3(0, +0.0000000001, 0));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
////// Emissive:

                #ifdef USE_SHADOWCAP
                    float3 normalDirectionShadowCap = normalize(mul( float3(normalLocal.r*_ShadowCapNormalMix,normalLocal.g*_ShadowCapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
                    float2 transformShadowCap = (mul( UNITY_MATRIX_V, float4(normalDirectionShadowCap,0) ).xyz.rgb.rg*0.5+0.5);
                    float4 _ShadowCapTexture_var = tex2D(_ShadowCapTexture,TRANSFORM_TEX(transformShadowCap, _ShadowCapTexture));
                    float4 _ShadowCapBlendMask_var = tex2D(_ShadowCapBlendMask,TRANSFORM_TEX(i.uv0, _ShadowCapBlendMask));
                    float3 shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb*_ShadowCapColor.rgb))*_ShadowCapBlendMask_var.rgb)*_ShadowCapBlend);
                #else
                    float3 shadowcap = float3(1000,1000,1000);
                #endif

                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 Diffuse = (_MainTex_var.rgb*_Color.rgb);


                float3 ShadeSH9Minus = ShadeSH9Indirect();
                float3 indirectLighting = saturate(ShadeSH9Minus);
                float3 ShadeSH9Plus = ShadeSH9Direct();
                float3 directLighting = saturate((ShadeSH9Plus+lightColor));
                float3 grayscale_vector = grayscale_vector_node();
                float grayscalelightcolor = dot(lightColor,grayscale_vector);
                float grayscaleDirectLighting = ((dot(lightDirection,normalDirection)*grayscalelightcolor*attenuation)+dot(ShadeSH9Normal( normalDirection ),grayscale_vector));
                float bottomIndirectLighting = dot(ShadeSH9Minus,grayscale_vector);
                float topIndirectLighting = dot(ShadeSH9Plus,grayscale_vector);
                float lightDifference = ((topIndirectLighting+grayscalelightcolor)-bottomIndirectLighting);
                float remappedLight = ((grayscaleDirectLighting-bottomIndirectLighting)/lightDifference);
                float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));
                float directContribution = 1.0 - ((1.0 - saturate(( (saturate(remappedLight) - _ShadowborderMin)) / (_ShadowborderMax - _ShadowborderMin))));

                #ifdef USE_SHADOW_STEPS
                    directContribution = min(1,floor(directContribution * _ShadowSteps) / (_ShadowSteps - 1));
                #endif

                directContribution = 1.0 - (1.0 - directContribution) * _ShadowStrengthMask_var * _ShadowStrength;

                // 頂点ライティングを処理
				float3 lightContribution = lerp(i.ambient, i.ambientAtten, 1-_PointShadowStrength);
                float3 directContributionVertex = (1.0 - (1.0 - saturate(saturate(lightContribution))));
                float3 finalVertexLight = saturate(directContributionVertex + (1 - (_PointShadowStrength * _ShadowStrengthMask_var)));
                float3 coloredLight = lightContribution;

                float3 finalLight = lerp(indirectLighting,directLighting,directContribution)+coloredLight;

                #ifdef USE_SHADE_TEXTURE
                    #ifdef USE_SHADOW_MIX
                        float3 shadeMixValue = finalLight;
                    #else
                        float3 shadeMixValue = directLighting;
                    #endif
                    #ifdef USE_CUSTOM_SHADOW_TEXTURE
                        float4 _ShadowPlanBCustomShadowTexture_var = tex2D(_ShadowPlanBCustomShadowTexture,TRANSFORM_TEX(i.uv0, _ShadowPlanBCustomShadowTexture));
                        float3 shadowCustomTexture = _ShadowPlanBCustomShadowTexture_var.rgb * _ShadowPlanBCustomShadowTextureRGB.rgb;
                        float3 ShadeMap = shadowCustomTexture*shadeMixValue;
                    #else
                        float3 Diff_HSV = CalculateHSV(Diffuse, _ShadowPlanBHueShiftFromBase, _ShadowPlanBSaturationFromBase, _ShadowPlanBValueFromBase);
                        float3 ShadeMap = Diff_HSV*shadeMixValue;
                    #endif
                    float3 ToonedMap = (lerp(ShadeMap,Diffuse*finalLight,finalLight)/1.0);
                #else
                    float3 ToonedMap = Diffuse*finalLight;
                #endif

                #ifdef USE_REFLECTION
                    float3 normalDirectionReflection = normalize(mul( float3(normalLocal.r*_ReflectionNormalMix, normalLocal.g*_ReflectionNormalMix, normalLocal.b), tangentTransform )); // Perturbed normals
                    float3 viewReflectDirection = reflect( -viewDirection, normalDirectionReflection );
                    float4 _ReflectionReflectionMask_var = tex2D(_ReflectionReflectionMask,TRANSFORM_TEX(i.uv0, _ReflectionReflectionMask));
                    float3 ReflectionMap = (_ReflectionReflectionPower*_ReflectionReflectionMask_var.rgb*texCUBElod(_ReflectionCubemap,float4(viewReflectDirection,_ReflectionRoughness*15.0)).rgb)*lerp(float3(1,1,1), finalLight,_ReflectionShadeMix);
                #else
                    float3 ReflectionMap = float3(0,0,0);
                #endif

                #ifdef USE_GLOSS
                    float _GlossBlendMask_var = tex2D(_GlossBlendMask, TRANSFORM_TEX(i.uv0, _GlossBlendMask));
                    float3 Gloss = ((max(0,dot(lightDirection,normalDirection))*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_GlossPower)))*_GlossColor.rgb)*lightColor*attenuation*_GlossBlend * _GlossBlendMask_var);
                #else
                    float3 Gloss = float3(0,0,0);
                #endif

                #ifdef USE_MATCAP
                    float3 normalDirectionMatcap = normalize(mul( float3(normalLocal.r*_MatcapNormalMix,normalLocal.g*_MatcapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
                    float2 transformMatcap = (mul( UNITY_MATRIX_V, float4(normalDirectionMatcap,0) ).xyz.rgb.rg*0.5+0.5);
                    float4 _MatcapTexture_var = tex2D(_MatcapTexture,TRANSFORM_TEX(transformMatcap, _MatcapTexture));
                    float4 _MatcapBlendMask_var = tex2D(_MatcapBlendMask,TRANSFORM_TEX(i.uv0, _MatcapBlendMask));
                    float3 matcap = ((_MatcapColor.rgb*_MatcapTexture_var.rgb)*_MatcapBlendMask_var.rgb*_MatcapBlend) * lerp(float3(1,1,1), finalLight,_MatcapShadeMix);
                #else
                    float3 matcap = float3(0,0,0);
                #endif

                #ifdef USE_RIM
                    float _RimBlendMask_var = tex2D(_RimBlendMask, TRANSFORM_TEX(i.uv0, _RimBlendMask));
                    float4 _RimTexture_var = tex2D(_RimTexture,TRANSFORM_TEX(i.uv0, _RimTexture));
                    float3 RimLight = (lerp( _RimTexture_var.rgb, Diffuse, _RimUseBaseTexture )*pow(1.0-max(0,dot(normalDirection, viewDirection)),_RimFresnelPower)*_RimBlend*_RimColor.rgb*_RimBlendMask_var*lerp(float3(1,1,1), finalLight,_RimShadeMix));
                #else
                    float3 RimLight = float3(0,0,0);
                #endif

                float4 _EmissionMap_var = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap));
                float3 emissive = max(((_EmissionMap_var.rgb*_EmissionColor.rgb)+matcap),RimLight);
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
            #pragma shader_feature USE_RIM
            #pragma shader_feature USE_MATCAP
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma multi_compile_fog
            #pragma only_renderers d3d9 d3d11 glcore gles
            #pragma target 3.0
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
            uniform float _GlossPower;
            uniform float4 _GlossColor;

            uniform float _PointShadowStrength;
            uniform sampler2D _ShadowStrengthMask; uniform float4 _ShadowStrengthMask_ST;
            uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
            uniform float _BumpScale;
            uniform sampler2D _EmissionMap; uniform float4 _EmissionMap_ST;
            uniform float4 _EmissionColor;

            uniform float _RimFresnelPower;
            uniform float4 _RimColor;
            uniform fixed _RimUseBaseTexture;
            uniform float _RimBlend;
            uniform float _RimShadeMix;
            uniform sampler2D _RimBlendMask; uniform float4 _RimBlendMask_ST;
            uniform sampler2D _RimTexture; uniform float4 _RimTexture_ST;

            uniform sampler2D _MatcapTexture; uniform float4 _MatcapTexture_ST;
            uniform float _MatcapBlend;
            uniform sampler2D _MatcapBlendMask; uniform float4 _MatcapBlendMask_ST;
            uniform float4 _MatcapColor;
            uniform float _MatcapNormalMix;
            uniform float _MatcapShadeMix;

            uniform float _GlossBlend;
            uniform sampler2D _GlossBlendMask; uniform float4 _GlossBlendMask_ST;
            uniform sampler2D _ShadowCapTexture; uniform float4 _ShadowCapTexture_ST;
            uniform sampler2D _ShadowCapBlendMask; uniform float4 _ShadowCapBlendMask_ST;
            uniform float _ShadowCapBlend;
            uniform float4 _ShadowCapColor;
            uniform float _ShadowCapNormalMix;
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
                o.pos = UnityObjectToClipPos( v.vertex );
                UNITY_TRANSFER_FOG(o,o.pos);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 _BumpMap_var = UnpackScaleNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)), _BumpScale);
                float3 normalLocal = _BumpMap_var.rgb;
                float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals

                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
                float3 lightColor = _LightColor0.rgb;
                float3 halfDirection = normalize(viewDirection+lightDirection);

                UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);
                float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                float3 Diffuse = (_MainTex_var.rgb*_Color.rgb);

                #ifdef USE_GLOSS
                    float _GlossBlendMask_var = tex2D(_GlossBlendMask, TRANSFORM_TEX(i.uv0, _GlossBlendMask));
                    float3 Gloss = ((max(0,dot(lightDirection,normalDirection))*pow(max(0,dot(normalDirection,halfDirection)),exp2(lerp(1,11,_GlossPower)))*_GlossColor.rgb)*_LightColor0.rgb*attenuation*_GlossBlend*_GlossBlendMask_var);
                #else
                    float3 Gloss = float3(0,0,0);
                #endif

                #ifdef USE_SHADOWCAP
                    float3 normalDirectionShadowCap = normalize(mul( float3(normalLocal.r*_ShadowCapNormalMix,normalLocal.g*_ShadowCapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
                    float2 transformShadowCap = (mul( UNITY_MATRIX_V, float4(normalDirectionShadowCap,0) ).xyz.rgb.rg*0.5+0.5);
                    float4 _ShadowCapTexture_var = tex2D(_ShadowCapTexture,TRANSFORM_TEX(transformShadowCap, _ShadowCapTexture));
                    float4 _ShadowCapBlendMask_var = tex2D(_ShadowCapBlendMask,TRANSFORM_TEX(i.uv0, _ShadowCapBlendMask));
                    float3 shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb*_ShadowCapColor.rgb))*_ShadowCapBlendMask_var.rgb)*_ShadowCapBlend);
                #else
                    float3 shadowcap = float3(1000,1000,1000);
                #endif

				float lightContribution = dot(normalize(_WorldSpaceLightPos0.xyz - i.posWorld.xyz),normalDirection)*attenuation;
                float3 directContribution = (1.0 - (1.0 - saturate(saturate(lightContribution))));
                float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));
                float3 finalLight = saturate(directContribution + ((1 - (_PointShadowStrength * _ShadowStrengthMask_var)) * attenuation));
                float3 coloredLight = lightColor*finalLight;

                #ifdef USE_MATCAP
                    float3 normalDirectionMatcap = normalize(mul( float3(normalLocal.r*_MatcapNormalMix,normalLocal.g*_MatcapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
                    float2 transformMatcap = (mul( UNITY_MATRIX_V, float4(normalDirectionMatcap,0) ).xyz.rgb.rg*0.5+0.5);
                    float4 _MatcapTexture_var = tex2D(_MatcapTexture,TRANSFORM_TEX(transformMatcap, _MatcapTexture));
                    float4 _MatcapBlendMask_var = tex2D(_MatcapBlendMask,TRANSFORM_TEX(i.uv0, _MatcapBlendMask));
                    float3 matcap = ((_MatcapColor.rgb*_MatcapTexture_var.rgb)*_MatcapBlendMask_var.rgb*_MatcapBlend);
                    matcap = min(matcap, matcap * (coloredLight * _MatcapShadeMix));
                #else
                    float3 matcap = float3(0,0,0);
                #endif

                #ifdef USE_RIM
                    float _RimBlendMask_var = tex2D(_RimBlendMask, TRANSFORM_TEX(i.uv0, _RimBlendMask));
                    float4 _RimTexture_var = tex2D(_RimTexture,TRANSFORM_TEX(i.uv0, _RimTexture));
                    float3 RimLight = (lerp( _RimTexture_var.rgb, Diffuse, _RimUseBaseTexture )*pow(1.0-max(0,dot(normalDirection, viewDirection)),_RimFresnelPower)*_RimBlend*_RimColor.rgb*_RimBlendMask_var);
                    RimLight = min(RimLight, RimLight * (coloredLight * _RimShadeMix));
                #else
                    float3 RimLight = float3(0,0,0);
                #endif

                float3 ToonedMap = Diffuse * coloredLight;
                float3 finalColor = matcap + min(max((max(ToonedMap, RimLight)),Gloss),shadowcap);

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
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform float4 _Color;
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
                    float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
                    float3 Diffuse = (_MainTex_var.rgb*_Color.rgb);
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
