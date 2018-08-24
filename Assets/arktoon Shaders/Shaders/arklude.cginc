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

float3 Shade4PointLightsIndirect(
    float4 lightPosX,
    float4 lightPosY,
    float4 lightPosZ,
    float3 lightColor0,
    float3 lightColor1,
    float3 lightColor2,
    float3 lightColor3,
    float4 lightAttenSq,
    float3 pos,float3 normal)
{
    // to light vectors
    float4 toLightX = lightPosX - pos.x;
    float4 toLightY = lightPosY - pos.y;
    float4 toLightZ = lightPosZ - pos.z;

    // squared lengths
    float4 lengthSq = 0;
    lengthSq += toLightX * toLightX;
    lengthSq += toLightY * toLightY;
    lengthSq += toLightZ * toLightZ;

    // don't produce NaNs if some vertex position overlaps with the light
    lengthSq = max(lengthSq, 0.000001);

    // NdotL
    float4 ndotl = 0;
    ndotl += toLightX * normal.x;
    ndotl += toLightY * normal.y;
    ndotl += toLightZ * normal.z;

    // correct NdotL
    float4 corr = rsqrt(lengthSq);
    ndotl = max(float4(0,0,0,0), ndotl * corr);

    // attenuation
    float4 atten = 1.0 / (1.0 + lengthSq * lightAttenSq);
    float4 diff = ndotl * atten;
    diff = min(1,corr* atten);

    // final color
    float3 col = 0;
    col += lightColor0 * sqrt(diff.x);
    col += lightColor1 * sqrt(diff.y);
    col += lightColor2 * sqrt(diff.z);
    col += lightColor3 * sqrt(diff.w);

    return col;

    //lightColor : 色と明るさ。その光がゼロ距離にいる時の強さ
    //corr
    //ndot1
    //atten :　
    //lengthSq : 距離の2乗
    //lightAttenSq : その光の減衰量（高い＝濃い＝その光のRangeが小さい）
    //diff : 光のかかりかたの最終計算結果
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
    float3 ambient : TEXCOORD6;
    float3 ambientAtten : TEXCOORD7;
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

    // 頂点ライティングが必要ば場合に取得
    #if UNITY_SHOULD_SAMPLE_SH
        #if defined(VERTEXLIGHT_ON)
            o.ambient = Shade4PointLights(
                unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                unity_LightColor[0].rgb, unity_LightColor[1].rgb,
                unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                unity_4LightAtten0, o.posWorld, o.normalDir
            );
            o.ambientAtten = Shade4PointLightsIndirect(
                unity_4LightPosX0, unity_4LightPosY0, unity_4LightPosZ0,
                unity_LightColor[0].rgb, unity_LightColor[1].rgb,
                unity_LightColor[2].rgb, unity_LightColor[3].rgb,
                unity_4LightAtten0, o.posWorld, o.normalDir
            );
        #else
            o.ambient = o.ambientAtten = 0;
        #endif
    #else
        o.ambient = o.ambientAtten = 0;
    #endif
    return o;
}