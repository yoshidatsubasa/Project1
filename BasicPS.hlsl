#include "Basic.hlsli"

Texture2D<float4> tex : register(t0);      // 0番スロットに設定されたテクスチャ
SamplerState smp : register(s0);          // 0番スロットに設定されたサンプラー

float4 main(VSOutput input) : SV_TARGET{

    //return float4(tex.Sample(smp, input.uv))*color;
    //return float4(input.normal, 1);  //RGBをそれぞれ法線のXYZ,Aを1で出力
    //return float4(1,1,1,1);
    float3 light = normalize(float3(1, -1, 1)); //右下奥　向きのライト
    float diffuse = saturate(dot(-light, input.normal));  //diffuseを[0,1]の範囲にClampする
    float brightness = diffuse + 0.3f;       //アンビエント項を0.3として計算
    //return float4(brightness, brightness, brightness, 1); //輝度をRGBに代入して出力
    float4 texcolor = float4(tex.Sample(smp, input.uv));
    return float4(texcolor.rgb * brightness,texcolor.a) * color;
}