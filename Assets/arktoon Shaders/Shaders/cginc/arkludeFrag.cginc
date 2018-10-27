uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
uniform float4 _Color;
uniform float _GlossPower;
uniform float4 _GlossColor;
uniform float _CutoutCutoutAdjust;
uniform float _ShadowPlanBDefaultShadowMix;
uniform float _ShadowPlanBHueShiftFromBase;
uniform float _ShadowPlanBSaturationFromBase;
uniform float _ShadowPlanBValueFromBase;

uniform float _ShadowPlanB2border;
uniform float _ShadowPlanB2borderBlur;
uniform float _ShadowPlanB2HueShiftFromBase;
uniform float _ShadowPlanB2SaturationFromBase;
uniform float _ShadowPlanB2ValueFromBase;
uniform sampler2D _ShadowPlanB2CustomShadowTexture; uniform float4 _ShadowPlanB2CustomShadowTexture_ST;
uniform float4 _ShadowPlanB2CustomShadowTextureRGB;

uniform float _Shadowborder;
uniform float _ShadowborderBlur;
uniform float _ShadowStrength;
uniform float _ShadowIndirectIntensity;
uniform int _ShadowSteps;
uniform float _PointAddIntensity;
uniform float _PointShadowStrength;
uniform float _PointShadowborder;
uniform float _PointShadowborderBlur;
uniform int _PointShadowSteps;
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

uniform float _ReflectionReflectionPower;
uniform sampler2D _ReflectionReflectionMask; uniform float4 _ReflectionReflectionMask_ST;
uniform float _ReflectionNormalMix;
uniform float _ReflectionShadeMix;
uniform float _ReflectionSuppressBaseColorValue;
uniform samplerCUBE _ReflectionCubemap;
uniform half4  _ReflectionCubemap_HDR;

uniform float _GlossBlend;
uniform sampler2D _GlossBlendMask; uniform float4 _GlossBlendMask_ST;
uniform float _RimFresnelPower;
uniform float _RimUpperSideWidth;
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
uniform float _ShadowCapNormalMix;
uniform float _VertexColorBlendDiffuse;
uniform float _VertexColorBlendEmissive;
uniform float _OtherShadowAdjust;
uniform float _OtherShadowBorderSharpness;
// uniform float4 _BackfaceColorMultiply;
uniform sampler2D _OutlineMask; uniform float4 _OutlineMask_ST;
uniform float _OutlineCutoffRange;
uniform float _OutlineTextureColorRate;
uniform float _OutlineShadeMix;

float4 frag(VertexOutput i) : COLOR {

    // i.normalDir = normalize(i.normalDir);
    float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
    float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
    float3 _BumpMap_var = UnpackScaleNormal(tex2D(_BumpMap,TRANSFORM_TEX(i.uv0, _BumpMap)), _BumpScale);
    float3 normalLocal = _BumpMap_var.rgb;
    float3 normalDirection = normalize(mul( normalLocal, tangentTransform )); // Perturbed normals
    float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz + float3(0, +0.0000000001, 0));
    float3 lightColor = _LightColor0.rgb;
    float3 halfDirection = normalize(viewDirection+lightDirection);

    UNITY_LIGHT_ATTENUATION(attenuation,i, i.posWorld.xyz);

    float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
    float3 Diffuse = (_MainTex_var.rgb*_Color.rgb);
    Diffuse = lerp(Diffuse, Diffuse * i.color,_VertexColorBlendDiffuse);

    // アウトラインであればDiffuseとColorを混ぜる
    Diffuse = lerp(Diffuse, (Diffuse * _OutlineTextureColorRate + i.col * (1 - _OutlineTextureColorRate)), i.isOutline);

    #ifdef ARKTOON_CUTOUT
        clip((_MainTex_var.a * _Color.a) - _CutoutCutoutAdjust);
    #endif

    #if defined(ARKTOON_CUTOUT) || defined(ARKTOON_FADE)
        if (i.isOutline) {
            float _OutlineMask_var = tex2D(_OutlineMask,TRANSFORM_TEX(i.uv0, _OutlineMask)).r;
            clip(_OutlineMask_var.r - _OutlineCutoffRange);
        }
    #endif

    // 光源サンプリング方法
    #ifdef _LIGHTSAMPLING_ARKTOON
        // 明るい部分と暗い部分をサンプリング・グレースケールでリマッピングして全面の光量を再計算
        float3 ShadeSH9Plus = GetSHLength();
        float3 ShadeSH9Minus = ShadeSH9(float4(0,0,0,1));
    #elif _LIGHTSAMPLING_CUBED
        // 空間上、真上を向いたときの光と真下を向いたときの光でサンプリング
        float3 ShadeSH9Plus = ShadeSH9Direct();
        float3 ShadeSH9Minus = ShadeSH9Indirect();
    #endif

    float3 directLighting = saturate((ShadeSH9Plus+lightColor));
    ShadeSH9Minus *= _ShadowIndirectIntensity;
    float3 indirectLighting = saturate(ShadeSH9Minus);

    float3 grayscale_vector = grayscale_vector_node();
    float grayscalelightcolor = dot(lightColor,grayscale_vector);
    float grayscaleDirectLighting = (((dot(lightDirection,normalDirection)*0.5+0.5)*grayscalelightcolor*attenuation)+dot(ShadeSH9Normal( normalDirection ),grayscale_vector));
    float bottomIndirectLighting = dot(ShadeSH9Minus,grayscale_vector);
    float topIndirectLighting = dot(ShadeSH9Plus,grayscale_vector);
    float lightDifference = ((topIndirectLighting+grayscalelightcolor)-bottomIndirectLighting);
    float remappedLight = ((grayscaleDirectLighting-bottomIndirectLighting)/lightDifference);
    float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));

    float ShadowborderMin = max(0, _Shadowborder - _ShadowborderBlur/2);
    float ShadowborderMax = min(1, _Shadowborder + _ShadowborderBlur/2);

    float grayscaleDirectLighting2 = (((dot(lightDirection,normalDirection)*0.5+0.5)*grayscalelightcolor) + dot(ShadeSH9Normal( normalDirection ),grayscale_vector));
    float remappedLight2 = ((grayscaleDirectLighting2-bottomIndirectLighting)/lightDifference);
    float directContribution = 1.0 - ((1.0 - saturate(( (saturate(remappedLight2) - ShadowborderMin)) / (ShadowborderMax - ShadowborderMin))));

    float selfShade = saturate(dot(lightDirection,normalDirection)+1+_OtherShadowAdjust);
    float otherShadow = saturate(saturate((attenuation-0.5)*2)+(1-selfShade)*_OtherShadowBorderSharpness);
    directContribution = lerp(0, directContribution, saturate(1-((1-otherShadow) * saturate(dot(lightColor,grayscale_for_light())*1.5))));

    #ifdef USE_SHADOW_STEPS
        directContribution = min(1,floor(directContribution * _ShadowSteps) / (_ShadowSteps - 1));
    #endif

    #ifdef USE_SHADE_TEXTURE
        directContribution = 1.0 - (1.0 - directContribution) * _ShadowStrengthMask_var * 1;
    #else
        directContribution = 1.0 - (1.0 - directContribution) * _ShadowStrengthMask_var * _ShadowStrength;
    #endif

    // 頂点ライティング：PixelLightから溢れた4光源をそれぞれ計算
    #ifdef USE_VERTEX_LIGHT
        float VertexShadowborderMin = max(0, _PointShadowborder - _PointShadowborderBlur/2.0);
        float VertexShadowborderMax = min(1, _PointShadowborder + _PointShadowborderBlur/2.0);
        float4 directContributionVertex = 1.0 - ((1.0 - saturate(( (saturate(i.ambientAttenuation) - VertexShadowborderMin)) / (VertexShadowborderMax - VertexShadowborderMin))));
        #ifdef USE_POINT_SHADOW_STEPS
            directContributionVertex = min(1,floor(directContributionVertex * _PointShadowSteps) / (_PointShadowSteps - 1));
        #endif
        float3 coloredLight_0 = max(directContributionVertex.r * i.lightColor0 * i.ambientAttenuation.r, i.lightColor0 * i.ambientIndirect.r * (1-_PointShadowStrength));
        float3 coloredLight_1 = max(directContributionVertex.g * i.lightColor1 * i.ambientAttenuation.g, i.lightColor1 * i.ambientIndirect.g * (1-_PointShadowStrength));
        float3 coloredLight_2 = max(directContributionVertex.b * i.lightColor2 * i.ambientAttenuation.b, i.lightColor2 * i.ambientIndirect.b * (1-_PointShadowStrength));
        float3 coloredLight_3 = max(directContributionVertex.a * i.lightColor3 * i.ambientAttenuation.a, i.lightColor3 * i.ambientIndirect.a * (1-_PointShadowStrength));
        float3 coloredLight_sum = (coloredLight_0 + coloredLight_1 + coloredLight_2 + coloredLight_3) * _PointAddIntensity;
    #else
        float3 coloredLight_sum = float3(0,0,0);
    #endif

    float3 finalLight = lerp(indirectLighting,directLighting,directContribution)+coloredLight_sum;

    // カスタム陰を使っている場合、directContributionや直前のfinalLightを使い、finalLightを上書きする
    #ifdef USE_SHADE_TEXTURE
        float3 shadeMixValue = lerp(directLighting, finalLight, _ShadowPlanBDefaultShadowMix);
        #ifdef USE_CUSTOM_SHADOW_TEXTURE
            float4 _ShadowPlanBCustomShadowTexture_var = tex2D(_ShadowPlanBCustomShadowTexture,TRANSFORM_TEX(i.uv0, _ShadowPlanBCustomShadowTexture));
            float3 shadowCustomTexture = _ShadowPlanBCustomShadowTexture_var.rgb * _ShadowPlanBCustomShadowTextureRGB.rgb;
            float3 ShadeMap = shadowCustomTexture*shadeMixValue;
        #else
            float3 Diff_HSV = CalculateHSV(Diffuse, _ShadowPlanBHueShiftFromBase, _ShadowPlanBSaturationFromBase, _ShadowPlanBValueFromBase);
            float3 ShadeMap = Diff_HSV*shadeMixValue;
        #endif

        #ifdef USE_CUSTOM_SHADOW_2ND
            float ShadowborderMin2 = max(0, (_ShadowPlanB2border * _Shadowborder) - _ShadowPlanB2borderBlur/2);
            float ShadowborderMax2 = min(1, (_ShadowPlanB2border * _Shadowborder) + _ShadowPlanB2borderBlur/2);
            float directContribution2 = 1.0 - ((1.0 - saturate(( (saturate(remappedLight2) - ShadowborderMin2)) / (ShadowborderMax2 - ShadowborderMin2))));  // /2の部分をパラメーターにしたい
            #ifdef USE_CUSTOM_SHADOW_TEXTURE_2ND
                float4 _ShadowPlanB2CustomShadowTexture_var = tex2D(_ShadowPlanB2CustomShadowTexture,TRANSFORM_TEX(i.uv0, _ShadowPlanB2CustomShadowTexture));
                float3 shadowCustomTexture2 = _ShadowPlanB2CustomShadowTexture_var.rgb * _ShadowPlanB2CustomShadowTextureRGB.rgb;
                shadowCustomTexture2 =  lerp(shadowCustomTexture2, shadowCustomTexture2 * i.color,_VertexColorBlendDiffuse); // 頂点カラーを合成
                float3 ShadeMap2 = shadowCustomTexture2*shadeMixValue;
            #else
                float3 Diff_HSV2 = CalculateHSV(Diffuse, _ShadowPlanB2HueShiftFromBase, _ShadowPlanB2SaturationFromBase, _ShadowPlanB2ValueFromBase);
                float3 ShadeMap2 = Diff_HSV2*shadeMixValue;
            #endif
            ShadeMap = lerp(ShadeMap2,ShadeMap,directContribution2);
        #endif

        finalLight = lerp(ShadeMap,directLighting,directContribution)+coloredLight_sum;
        float3 ToonedMap = lerp(ShadeMap,Diffuse*finalLight,finalLight);
    #else
        float3 ToonedMap = Diffuse*finalLight;
    #endif

    // アウトラインであればShadeMixを反映
    ToonedMap = lerp(ToonedMap, (ToonedMap * _OutlineShadeMix + (Diffuse+(Diffuse*coloredLight_sum)) * (1 - _OutlineShadeMix)), i.isOutline);

    float3 ReflectionMap = float3(0,0,0);
    float3 specular = float3(0,0,0);
    float3 matcap = float3(0,0,0);
    float3 RimLight = float3(0,0,0);
    float3 shadowcap = float3(1000,1000,1000);

    #ifdef USE_OUTLINE
    if (!i.isOutline) {
    #endif
        // オプション：Reflection
        #ifdef USE_REFLECTION
            float3 normalDirectionReflection = normalize(mul( float3(normalLocal.r*_ReflectionNormalMix,normalLocal.g*_ReflectionNormalMix,normalLocal.b), tangentTransform ));
            float reflNdotV = abs(dot( normalDirectionReflection, viewDirection ));
            float _ReflectionSmoothnessMask_var = tex2D(_ReflectionReflectionMask,TRANSFORM_TEX(i.uv0, _ReflectionReflectionMask));
            float reflectionSmoothness = _ReflectionReflectionPower*_ReflectionSmoothnessMask_var;
            float perceptualRoughnessRefl = 1.0 - _ReflectionReflectionPower;
            float3 reflDir = reflect(-viewDirection, normalDirectionReflection);
            float roughnessRefl = SmoothnessToRoughness(reflectionSmoothness);
            #ifdef USE_REFLECTION_PROBE
                float3 indirectSpecular = GetIndirectSpecular(lightColor, lightDirection,
                    normalDirectionReflection, viewDirection, reflDir, attenuation, roughnessRefl, i.posWorld.xyz
                );
                if (any(indirectSpecular.xyz) == 0) indirectSpecular = GetIndirectSpecularCubemap(_ReflectionCubemap, _ReflectionCubemap_HDR, reflDir, roughnessRefl);
            #else
                float3 indirectSpecular = GetIndirectSpecularCubemap(_ReflectionCubemap, _ReflectionCubemap_HDR, reflDir, roughnessRefl);
            #endif
            float3 specularColorRefl = _ReflectionReflectionPower;
            float specularMonochromeRefl;
            float3 diffuseColorRefl = Diffuse;
            diffuseColorRefl = DiffuseAndSpecularFromMetallic( diffuseColorRefl, specularColorRefl, specularColorRefl, specularMonochromeRefl );
            specularMonochromeRefl = 1.0-specularMonochromeRefl;
            half grazingTermRefl = saturate( reflectionSmoothness + specularMonochromeRefl );
            #ifdef UNITY_COLORSPACE_GAMMA
                half surfaceReduction = 1.0-0.28*roughness*perceptualRoughnessRefl;
            #else
                half surfaceReduction = 1.0/(roughnessRefl*roughnessRefl + 1.0);
            #endif
            indirectSpecular *= FresnelLerp (specularColorRefl, grazingTermRefl, reflNdotV);
            indirectSpecular *= surfaceReduction *lerp(float3(1,1,1), finalLight,_ReflectionShadeMix);
            float reflSuppress = _ReflectionSuppressBaseColorValue * _ReflectionSmoothnessMask_var;
            ToonedMap = lerp(ToonedMap,ToonedMap * (1-surfaceReduction), reflSuppress);
            ReflectionMap = indirectSpecular*lerp(float3(1,1,1), finalLight,_ReflectionShadeMix);
        #endif
        // オプション：Gloss
        #ifdef USE_GLOSS
            float glossNdotV = abs(dot( normalDirection, viewDirection ));
            float _GlossBlendMask_var = tex2D(_GlossBlendMask, TRANSFORM_TEX(i.uv0, _GlossBlendMask));
            float gloss = _GlossBlend * _GlossBlendMask_var;
            float perceptualRoughness = 1.0 - gloss;
            float roughness = perceptualRoughness * perceptualRoughness;
            float specPow = exp2( gloss * 10.0+1.0);
            float NdotL = saturate(dot( normalDirection, lightDirection ));
            float LdotH = saturate(dot(lightDirection, halfDirection));
            float3 specularColor = _GlossPower;
            float specularMonochrome;
            float3 diffuseColor = Diffuse;
            diffuseColor = DiffuseAndSpecularFromMetallic( diffuseColor, specularColor, specularColor, specularMonochrome );
            specularMonochrome = 1.0-specularMonochrome;
            float NdotH = saturate(dot( normalDirection, halfDirection ));
            float VdotH = saturate(dot( viewDirection, halfDirection ));
            float visTerm = SmithJointGGXVisibilityTerm( NdotL, glossNdotV, roughness );
            float normTerm = GGXTerm(NdotH, roughness);
            float specularPBL = (visTerm*normTerm) * UNITY_PI;
            #ifdef UNITY_COLORSPACE_GAMMA
                specularPBL = sqrt(max(1e-4h, specularPBL));
            #endif
            specularPBL = max(0, specularPBL * NdotL);
            #if defined(_SPECULARHIGHLIGHTS_OFF)
                specularPBL = 0.0;
            #endif
            specularPBL *= any(specularColor) ? 1.0 : 0.0;
            float3 attenColor = attenuation * _LightColor0.xyz;
            float3 directSpecular = attenColor*specularPBL*FresnelTerm(specularColor, LdotH);
            half grazingTerm = saturate( gloss + specularMonochrome );
            specular = attenuation * directSpecular * _GlossColor.rgb;
        #endif
        // オプション：MatCap
        #ifdef USE_MATCAP
            float3 normalDirectionMatcap = normalize(mul( float3(normalLocal.r*_MatcapNormalMix,normalLocal.g*_MatcapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
            float2 transformMatcap = (mul( UNITY_MATRIX_V, float4(normalDirectionMatcap,0) ).xyz.rgb.rg*0.5+0.5);
            float4 _MatcapTexture_var = tex2D(_MatcapTexture,TRANSFORM_TEX(transformMatcap, _MatcapTexture));
            float4 _MatcapBlendMask_var = tex2D(_MatcapBlendMask,TRANSFORM_TEX(i.uv0, _MatcapBlendMask));
            matcap = ((_MatcapColor.rgb*_MatcapTexture_var.rgb)*_MatcapBlendMask_var.rgb*_MatcapBlend) * lerp(float3(1,1,1), finalLight,_MatcapShadeMix);
        #endif
        // オプション：Rim
        #ifdef USE_RIM
            float _RimBlendMask_var = tex2D(_RimBlendMask, TRANSFORM_TEX(i.uv0, _RimBlendMask));
            float4 _RimTexture_var = tex2D(_RimTexture,TRANSFORM_TEX(i.uv0, _RimTexture));
            RimLight = (
                            lerp( _RimTexture_var.rgb, Diffuse, _RimUseBaseTexture )
                            * pow(
                                min(1.0, 1.0 - max(0, dot(normalDirection * i.faceSign, viewDirection) ) + _RimUpperSideWidth)
                                , _RimFresnelPower
                                )
                            * _RimBlend
                            * _RimColor.rgb
                            * _RimBlendMask_var
                            * lerp(float3(1,1,1), finalLight,_RimShadeMix)
                        );
        #endif
        // オプション:ShadeCap
        #ifdef USE_SHADOWCAP
            float3 normalDirectionShadowCap = normalize(mul( float3(normalLocal.r*_ShadowCapNormalMix,normalLocal.g*_ShadowCapNormalMix,normalLocal.b), tangentTransform )); // Perturbed normals
            float2 transformShadowCap = (mul( UNITY_MATRIX_V, float4(normalDirectionShadowCap,0) ).xyz.rgb.rg*0.5+0.5);
            float4 _ShadowCapTexture_var = tex2D(_ShadowCapTexture,TRANSFORM_TEX(transformShadowCap, _ShadowCapTexture));
            float4 _ShadowCapBlendMask_var = tex2D(_ShadowCapBlendMask,TRANSFORM_TEX(i.uv0, _ShadowCapBlendMask));
            shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb))*_ShadowCapBlendMask_var.rgb)*_ShadowCapBlend);
        #endif

    #ifdef USE_OUTLINE
    }
    #endif

    float3 finalcolor2 = ToonedMap+ReflectionMap + specular;


    // ShadeCapのブレンドモード
    #ifdef USE_SHADOWCAP
        #ifdef _SHADOWCAPBLENDMODE_DARKEN
            finalcolor2 = min(finalcolor2, shadowcap);
        #elif _SHADOWCAPBLENDMODE_MULTIPLY
            finalcolor2 = finalcolor2 * shadowcap;
        #endif
    #endif

    // MatCapのブレンドモード
    #ifdef USE_MATCAP
        #ifdef _MATCAPBLENDMODE_LIGHTEN
            finalcolor2 = max(finalcolor2, matcap);
        #elif _MATCAPBLENDMODE_ADD
            finalcolor2 = finalcolor2 + matcap;
        #elif _MATCAPBLENDMODE_SCREEN
            finalcolor2 = 1-(1-finalcolor2) * (1-matcap);
        #endif
    #endif

    // EmissiveColorはこのタイミングで合成
    float3 _Emission = tex2D(_EmissionMap,TRANSFORM_TEX(i.uv0, _EmissionMap)).rgb *_EmissionColor.rgb;
    float3 emissive = max(lerp(_Emission.rgb, _Emission.rgb * i.color, _VertexColorBlendEmissive), RimLight) * !i.isOutline;

    float3 finalColor = emissive + finalcolor2;

    #ifdef ARKTOON_FADE
        fixed4 finalRGBA = fixed4(finalColor,(_MainTex_var.a*_Color.a));
    #else
        fixed4 finalRGBA = fixed4(finalColor,1);
    #endif
    UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
    return finalRGBA;
}