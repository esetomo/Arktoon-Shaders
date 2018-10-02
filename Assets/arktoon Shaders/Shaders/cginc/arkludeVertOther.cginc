#include "UnityCG.cginc"
#include "AutoLight.cginc"
#include "Lighting.cginc"

float3 ShadeSH9Indirect(){
    return ShadeSH9(half4(0.0, -1.0, 0.0, 1.0));
}

float3 ShadeSH9Direct(){
    return ShadeSH9(half4(0.0, 1.0, 0.0, 1.0));
}

float3 grayscale_vector_node(){
    return float3(0, 0.3823529, 0.01845836);
}

float3 grayscale_for_light(){
    return float3(0.298912, 0.586611, 0.114478);
}

float3 ShadeSH9Normal( float3 normalDirection ){
    return ShadeSH9(half4(normalDirection, 1.0));
}

float3 CalculateHSV(float3 baseTexture, float hueShift, float saturation, float value ){
    float4 node_5443_k = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    float4 node_5443_p = lerp(float4(float4(baseTexture,0.0).zy, node_5443_k.wz), float4(float4(baseTexture,0.0).yz, node_5443_k.xy), step(float4(baseTexture,0.0).z, float4(baseTexture,0.0).y));
    float4 node_5443_q = lerp(float4(node_5443_p.xyw, float4(baseTexture,0.0).x), float4(float4(baseTexture,0.0).x, node_5443_p.yzx), step(node_5443_p.x, float4(baseTexture,0.0).x));
    float node_5443_d = node_5443_q.x - min(node_5443_q.w, node_5443_q.y);
    float node_5443_e = 1.0e-10;
    float3 node_5443 = float3(abs(node_5443_q.z + (node_5443_q.w - node_5443_q.y) / (6.0 * node_5443_d + node_5443_e)), node_5443_d / (node_5443_q.x + node_5443_e), node_5443_q.x);;
    return (lerp(float3(1,1,1),saturate(3.0*abs(1.0-2.0*frac((hueShift+node_5443.r)+float3(0.0,-1.0/3.0,1.0/3.0)))-1),(node_5443.g*saturation))*(value*node_5443.b));
}

struct v2g
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 tangent : TANGENT;
	float2 uv0 : TEXCOORD0;
	float4 posWorld : TEXCOORD2;
	float3 normalDir : TEXCOORD3;
	float3 tangentDir : TEXCOORD4;
	float3 bitangentDir : TEXCOORD5;
	float4 pos : CLIP_POS;
	SHADOW_COORDS(6)
	UNITY_FOG_COORDS(7)
    fixed4 color : COLOR;
    float3 lightColor0 : LIGHT_COLOR0;
    float3 lightColor1 : LIGHT_COLOR1;
    float3 lightColor2 : LIGHT_COLOR2;
    float3 lightColor3 : LIGHT_COLOR3;
    float4 ambientAttenuation : AMBIENT_ATTEN;
    float4 ambientIndirect : AMBIENT_INDIRECT;
};


v2g vert(appdata_full v) {
	v2g o;
	o.uv0 = v.texcoord;
	o.normal = v.normal;
	o.tangent = v.tangent;
    o.color = v.color;
	o.normalDir = normalize(UnityObjectToWorldNormal(v.normal));
	o.tangentDir = normalize(mul(unity_ObjectToWorld, float4(v.tangent.xyz, 0.0)).xyz);
	o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
	float4 objPos = mul(unity_ObjectToWorld, float4(0, 0, 0, 1));
	o.posWorld = mul(unity_ObjectToWorld, v.vertex);
	float3 lightColor = _LightColor0.rgb;
	o.vertex = v.vertex;
	o.pos = UnityObjectToClipPos(v.vertex);
	TRANSFER_SHADOW(o);
	UNITY_TRANSFER_FOG(o, o.pos);

    // 頂点ライティングが必要な場合に取得
    #if UNITY_SHOULD_SAMPLE_SH
        #if defined(VERTEXLIGHT_ON) && defined(USE_VERTEX_LIGHT)
            o.lightColor0 = unity_LightColor[0].rgb;
            o.lightColor1 = unity_LightColor[1].rgb;
            o.lightColor2 = unity_LightColor[2].rgb;
            o.lightColor3 = unity_LightColor[3].rgb;

            // Shade4PointLightsを展開して改変
            // {
                // to light vectors
                float4 toLightX = unity_4LightPosX0 - o.posWorld.x;
                float4 toLightY = unity_4LightPosY0 - o.posWorld.y;
                float4 toLightZ = unity_4LightPosZ0 - o.posWorld.z;
                // squared lengths
                float4 lengthSq = 0;
                lengthSq += toLightX * toLightX;
                lengthSq += toLightY * toLightY;
                lengthSq += toLightZ * toLightZ;
                // don't produce NaNs if some vertex position overlaps with the light
                lengthSq = max(lengthSq, 0.000001);

                // NdotL
                float4 ndotl = 0;
                ndotl += toLightX * o.normalDir.x;
                ndotl += toLightY * o.normalDir.y;
                ndotl += toLightZ * o.normalDir.z;
                // correct NdotL
                float4 corr = rsqrt(lengthSq);
                ndotl = max (float4(0,0,0,0), ndotl * corr);
                // attenuation
                float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
                float4 diff = ndotl * atten;
            // }

            o.ambientAttenuation = diff;
            o.ambientIndirect = sqrt(min(1,corr* atten));

        #else
            o.lightColor0 = 0;
            o.lightColor1 = 0;
            o.lightColor2 = 0;
            o.lightColor3 = 0;
            o.ambientIndirect = o.ambientAttenuation = 0;
        #endif
    #else
        o.lightColor0 = 0;
        o.lightColor1 = 0;
        o.lightColor2 = 0;
        o.lightColor3 = 0;
        o.ambientIndirect = o.ambientAttenuation = 0;
    #endif
    return o;
}




struct VertexOutput {
    float4 pos : SV_POSITION;
    float2 uv0 : TEXCOORD0;
    float4 posWorld : TEXCOORD2;
    float3 normalDir : TEXCOORD3;
    float3 tangentDir : TEXCOORD4;
    float3 bitangentDir : TEXCOORD5;
    fixed4 col : COLOR0;
	bool is_outline : IS_OUTLINE;
    SHADOW_COORDS(6)
    UNITY_FOG_COORDS(7)
    fixed4 color : COLOR1;
    float3 lightColor0 : LIGHT_COLOR0;
    float3 lightColor1 : LIGHT_COLOR1;
    float3 lightColor2 : LIGHT_COLOR2;
    float3 lightColor3 : LIGHT_COLOR3;
    float4 ambientAttenuation : AMBIENT_ATTEN;
    float4 ambientIndirect : AMBIENT_INDIRECT;
};


// struct v2g
// {
// 	float4 vertex : POSITION;
// 	float3 normal : NORMAL;
// 	float4 tangent : TANGENT;
// 	float2 uv0 : TEXCOORD0;
// 	float2 uv1 : TEXCOORD1;
// 	float4 posWorld : TEXCOORD2;
// 	float3 normalDir : TEXCOORD3;
// 	float3 tangentDir : TEXCOORD4;
// 	float3 bitangentDir : TEXCOORD5;
// 	float4 pos : CLIP_POS;
// 	SHADOW_COORDS(6)
// 	UNITY_FOG_COORDS(7)
//     fixed4 color : COLOR;
//     float3 lightColor0 : LIGHT_COLOR0;
//     float3 lightColor1 : LIGHT_COLOR1;
//     float3 lightColor2 : LIGHT_COLOR2;
//     float3 lightColor3 : LIGHT_COLOR3;
//     float4 ambientAttenuation : AMBIENT_ATTEN;
//     float4 ambientIndirect : AMBIENT_INDIRECT;
// };


uniform float _Shadow;
uniform float _Cutoff;
uniform float _outline_width;
uniform float4 _outline_color;

[maxvertexcount(6)]
void geom(triangle v2g IN[3], inout TriangleStream<VertexOutput> tristream)
{
	VertexOutput o;
	#if 1
	for (int i = 2; i >= 0; i--)
	{
		o.pos = UnityObjectToClipPos(IN[i].vertex + normalize(IN[i].normal) * (0 * .01));
		o.uv0 = IN[i].uv0;
		o.col = fixed4( _outline_color.r, _outline_color.g, _outline_color.b, 1);
        o.color = IN[i].color;
		o.posWorld = mul(unity_ObjectToWorld, IN[i].vertex);
		o.normalDir = UnityObjectToWorldNormal(IN[i].normal);
		o.tangentDir = IN[i].tangentDir;
		o.bitangentDir = IN[i].bitangentDir;
		o.posWorld = mul(unity_ObjectToWorld, IN[i].vertex);
		o.is_outline = true;

		// Pass-through the shadow coordinates if this pass has shadows.
		#if defined (SHADOWS_SCREEN) || ( defined (SHADOWS_DEPTH) && defined (SPOT) ) || defined (SHADOWS_CUBE)
		o._ShadowCoord = IN[i]._ShadowCoord;
		#endif

		// Pass-through the fog coordinates if this pass has shadows.
		#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
		o.fogCoord = IN[i].fogCoord;
		#endif

        o.lightColor0          = IN[i].lightColor0;
        o.lightColor1          = IN[i].lightColor1;
        o.lightColor2          = IN[i].lightColor2;
        o.lightColor3          = IN[i].lightColor3;
        o.ambientAttenuation   = IN[i].ambientAttenuation;
        o.ambientIndirect      = IN[i].ambientIndirect;

		tristream.Append(o);
	}

	tristream.RestartStrip();
	#endif

	for (int ii = 0; ii < 3; ii++)
	{
		o.pos = UnityObjectToClipPos(IN[ii].vertex);
		o.uv0 = IN[ii].uv0;
		o.col = fixed4(1., 1., 1., 0.);
        o.color = IN[ii].color;
		o.posWorld = mul(unity_ObjectToWorld, IN[ii].vertex);
		o.normalDir = UnityObjectToWorldNormal(IN[ii].normal);
		o.tangentDir = IN[ii].tangentDir;
		o.bitangentDir = IN[ii].bitangentDir;
		o.posWorld = mul(unity_ObjectToWorld, IN[ii].vertex);
		o.is_outline = false;

		// Pass-through the shadow coordinates if this pass has shadows.
		#if defined (SHADOWS_SCREEN) || ( defined (SHADOWS_DEPTH) && defined (SPOT) ) || defined (SHADOWS_CUBE)
		o._ShadowCoord = IN[ii]._ShadowCoord;
		#endif

		// Pass-through the fog coordinates if this pass has shadows.
		#if defined(FOG_LINEAR) || defined(FOG_EXP) || defined(FOG_EXP2)
		o.fogCoord = IN[ii].fogCoord;
		#endif

        o.lightColor0          = IN[ii].lightColor0;
        o.lightColor1          = IN[ii].lightColor1;
        o.lightColor2          = IN[ii].lightColor2;
        o.lightColor3          = IN[ii].lightColor3;
        o.ambientAttenuation   = IN[ii].ambientAttenuation;
        o.ambientIndirect      = IN[ii].ambientIndirect;

		tristream.Append(o);
	}

	tristream.RestartStrip();
}



// v2g vert (appdata_full v) {
//     v2g o;
//     o.uv0 = v.texcoord;
//     o.color = v.color;
//     o.normalDir = UnityObjectToWorldNormal(v.normal);
//     o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
//     o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
//     o.posWorld = mul(unity_ObjectToWorld, v.vertex);
//     o.pos = UnityObjectToClipPos( v.vertex );
//     UNITY_TRANSFER_FOG(o,o.pos);
//     TRANSFER_VERTEX_TO_FRAGMENT(o)

//     // 頂点ライティングが必要な場合に取得
//     #if UNITY_SHOULD_SAMPLE_SH
//         #if defined(VERTEXLIGHT_ON) && defined(USE_VERTEX_LIGHT)
//             o.lightColor0 = unity_LightColor[0].rgb;
//             o.lightColor1 = unity_LightColor[1].rgb;
//             o.lightColor2 = unity_LightColor[2].rgb;
//             o.lightColor3 = unity_LightColor[3].rgb;

//             // Shade4PointLightsを展開して改変
//             // {
//                 // to light vectors
//                 float4 toLightX = unity_4LightPosX0 - o.posWorld.x;
//                 float4 toLightY = unity_4LightPosY0 - o.posWorld.y;
//                 float4 toLightZ = unity_4LightPosZ0 - o.posWorld.z;
//                 // squared lengths
//                 float4 lengthSq = 0;
//                 lengthSq += toLightX * toLightX;
//                 lengthSq += toLightY * toLightY;
//                 lengthSq += toLightZ * toLightZ;
//                 // don't produce NaNs if some vertex position overlaps with the light
//                 lengthSq = max(lengthSq, 0.000001);

//                 // NdotL
//                 float4 ndotl = 0;
//                 ndotl += toLightX * o.normalDir.x;
//                 ndotl += toLightY * o.normalDir.y;
//                 ndotl += toLightZ * o.normalDir.z;
//                 // correct NdotL
//                 float4 corr = rsqrt(lengthSq);
//                 ndotl = max (float4(0,0,0,0), ndotl * corr);
//                 // attenuation
//                 float4 atten = 1.0 / (1.0 + lengthSq * unity_4LightAtten0);
//                 float4 diff = ndotl * atten;
//             // }

//             o.ambientAttenuation = diff;
//             o.ambientIndirect = sqrt(min(1,corr* atten));

//         #else
//             o.ambientIndirect = o.ambientAttenuation = 0;
//         #endif
//     #else
//         o.ambientIndirect = o.ambientAttenuation = 0;
//     #endif
//     return o;
// }




float3 GetIndirectSpecular(float3 lightColor, float3 lightDirection, float3 normalDirection,float3 viewDirection,
float3 viewReflectDirection, float attenuation, float roughness, float3 worldPos){
    UnityLight light;
    light.color = lightColor;
    light.dir = lightDirection;
    light.ndotl = max(0.0h,dot( normalDirection, lightDirection));
    UnityGIInput d;
    d.light = light;
    d.worldPos = worldPos;
    d.worldViewDir = viewDirection;
    d.atten = attenuation;
    d.ambient = 0.0h;
    d.boxMax[0] = unity_SpecCube0_BoxMax;
    d.boxMin[0] = unity_SpecCube0_BoxMin;
    d.probePosition[0] = unity_SpecCube0_ProbePosition;
    d.probeHDR[0] = unity_SpecCube0_HDR;
    d.boxMax[1] = unity_SpecCube1_BoxMax;
    d.boxMin[1] = unity_SpecCube1_BoxMin;
    d.probePosition[1] = unity_SpecCube1_ProbePosition;
    d.probeHDR[1] = unity_SpecCube1_HDR;
    Unity_GlossyEnvironmentData ugls_en_data;
    ugls_en_data.roughness = roughness;
    ugls_en_data.reflUVW = viewReflectDirection;
    float3 indirectSpecular = UnityGI_IndirectSpecular(d, 1.0h, ugls_en_data);
    return indirectSpecular;
}
