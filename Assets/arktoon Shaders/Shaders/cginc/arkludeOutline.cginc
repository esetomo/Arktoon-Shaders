#include "UnityCG.cginc"
uniform float _CutoutCutoutAdjust;
uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
uniform float4 _Color;
uniform float _OutlineWidth;
uniform float _OutlineTextureColorRate;
uniform sampler2D _OutlineWidthMask; uniform float4 _OutlineWidthMask_ST;
uniform float4 _OutlineColor;
uniform float _VertexColorBlendDiffuse;
uniform float _VertexColorBlendEmissive;

struct VertexOutput {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    UNITY_FOG_COORDS(1)
    fixed4 color : COLOR;
};

VertexOutput vert (appdata_full v) {
    #ifdef USE_OUTLINE
        VertexOutput o = (VertexOutput)0;
        o.uv0 = v.texcoord;
        o.color = v.color;
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
        Diffuse = lerp(Diffuse, Diffuse * i.color.rgb, _VertexColorBlendDiffuse);
        #ifdef ARKTOON_CUTOUT
            clip((_MainTex_var.a * _Color.a) - _CutoutCutoutAdjust);
        #endif
        return fixed4(lerp(_OutlineColor.rgb,Diffuse,_OutlineTextureColorRate),0);
    #else
        return fixed4(0,0,0,0);
    #endif
}