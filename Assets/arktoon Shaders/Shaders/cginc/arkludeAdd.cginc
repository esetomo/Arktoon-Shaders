#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"

uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
uniform float4 _Color;
uniform float _GlossPower;
uniform float4 _GlossColor;

uniform float _CutoutCutoutAdjust;
uniform float _PointAddIntensity;
uniform float _PointShadowStrength;
uniform float _PointShadowborder;
uniform float _PointShadowborderBlur;
uniform int _PointShadowSteps;
uniform sampler2D _ShadowStrengthMask; uniform float4 _ShadowStrengthMask_ST;
uniform sampler2D _BumpMap; uniform float4 _BumpMap_ST;
uniform float _BumpScale;

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
uniform float _ShadowCapNormalMix;

uniform float _VertexColorBlendDiffuse;

struct VertexOutput {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float4 posWorld : TEXCOORD1;
    float3 normalDir : TEXCOORD2;
    float3 tangentDir : TEXCOORD3;
    float3 bitangentDir : TEXCOORD4;
    LIGHTING_COORDS(5,6)
    UNITY_FOG_COORDS(7)
    fixed4 color : COLOR;
};

VertexOutput vert (appdata_full v) {
    VertexOutput o = (VertexOutput)0;
    o.uv0 = v.texcoord;
    o.color = v.color;
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
    Diffuse = lerp(Diffuse, Diffuse * i.color,_VertexColorBlendDiffuse); // 頂点カラーを合成

    #ifdef ARKTOON_CUTOUT
        clip((_MainTex_var.a * _Color.a) - _CutoutCutoutAdjust);
    #endif

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
        float3 shadowcap = (1.0 - ((1.0 - (_ShadowCapTexture_var.rgb))*_ShadowCapBlendMask_var.rgb)*_ShadowCapBlend);
    #else
        float3 shadowcap = float3(1000,1000,1000);
    #endif

    float ShadowborderMin = max(0, _PointShadowborder - _PointShadowborderBlur/2);
    float ShadowborderMax = min(1, _PointShadowborder + _PointShadowborderBlur/2);

    float lightContribution = dot(normalize(_WorldSpaceLightPos0.xyz - i.posWorld.xyz),normalDirection)*attenuation;
    float directContribution = 1.0 - ((1.0 - saturate(( (saturate(lightContribution) - ShadowborderMin)) / (ShadowborderMax - ShadowborderMin))));
    #ifdef USE_POINT_SHADOW_STEPS
        directContribution = min(1,floor(directContribution * _PointShadowSteps) / (_PointShadowSteps - 1));
    #endif
    float _ShadowStrengthMask_var = tex2D(_ShadowStrengthMask, TRANSFORM_TEX(i.uv0, _ShadowStrengthMask));
    float3 finalLight = saturate(directContribution + ((1 - (_PointShadowStrength * _ShadowStrengthMask_var)) * attenuation));
    float3 coloredLight = saturate(lightColor*finalLight*_PointAddIntensity);

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
    float3 finalColor = max((max(ToonedMap, RimLight)),Gloss);

    // ShadeCapのブレンドモード
    #ifdef USE_SHADOWCAP
        #ifdef _SHADOWCAPBLENDMODE_DARKEN
            finalColor = min(finalColor, shadowcap);
        #elif _SHADOWCAPBLENDMODE_MULTIPLY
            finalColor = finalColor * shadowcap;
        #endif
    #endif

    // MatCapのブレンドモード
    #ifdef USE_MATCAP
        #ifdef _MATCAPBLENDMODE_LIGHTEN
            finalColor = max(finalColor, matcap);
        #elif _MATCAPBLENDMODE_ADD
            finalColor = finalColor + matcap;
        #elif _MATCAPBLENDMODE_SCREEN
            finalColor = 1-(1-finalColor) * (1-matcap);
        #endif
    #endif

    #ifdef ARKTOON_FADE
        fixed4 finalRGBA = fixed4(finalColor * (_MainTex_var.a * _Color.a),0);
    #else
        fixed4 finalRGBA = fixed4(finalColor * 1,0);
    #endif
    UNITY_APPLY_FOG(i.fogCoord, finalRGBA);
    return finalRGBA;
}