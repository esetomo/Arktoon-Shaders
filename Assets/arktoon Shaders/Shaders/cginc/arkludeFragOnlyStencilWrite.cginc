uniform sampler2D _StencilMaskTex; uniform float4 _StencilMaskTex_ST;
uniform float _StencilMaskAdjust;

uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
uniform float _CutoutCutoutAdjust;
uniform float4 _Color;

float4 frag(VertexOutput i) : COLOR {
    // MainTex, Color, StencilMask情報をもとにClipするだけ
    float4 _MainTex_var = tex2D(_MainTex,TRANSFORM_TEX(i.uv0, _MainTex));
    float4 _StencilMaskTex_var = tex2D(_StencilMaskTex,TRANSFORM_TEX(i.uv0, _StencilMaskTex));

    clip(min((_MainTex_var.a *_Color.a) - _CutoutCutoutAdjust, _StencilMaskTex_var - _StencilMaskAdjust));

    float4 finalRGBA = float4(0,0,0,0);
    return finalRGBA;
}