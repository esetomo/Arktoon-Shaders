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
    float3 lightColor0 : LIGHT_COLOR0;
    float3 lightColor1 : LIGHT_COLOR1;
    float3 lightColor2 : LIGHT_COLOR2;
    float3 lightColor3 : LIGHT_COLOR3;
    float4 ambientAttenuation : AMBIENT_ATTEN;
    float4 ambientIndirect : AMBIENT_INDIRECT;
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
            o.ambientIndirect = o.ambientAttenuation = 0;
        #endif
    #else
        o.ambientIndirect = o.ambientAttenuation = 0;
    #endif
    return o;
}