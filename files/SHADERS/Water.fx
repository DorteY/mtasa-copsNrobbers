// By Drew Watts -- Based of a method by Crytek with some edits
// www.drewwatts.net
// Ported to MTA by Sam@ke

float wetValue = 0;
int wetType = 1;
texture screenSource;
texture waterNormal;
texture waterDrop;
float Time : Time;

sampler ScreenSourceSampler = sampler_state
{
    Texture = (screenSource);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};


sampler WaterNormalSampler = sampler_state
{
    Texture = (waterNormal);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};

sampler WaterDropSampler = sampler_state
{
    Texture = (waterDrop);
	MinFilter = Linear;
    MagFilter = Linear;
    MipFilter = Linear;
    AddressU = Mirror;
    AddressV = Mirror;
};


float4 PixelShaderFunction(float2 TexCoords : TEXCOORD) : COLOR
{	
	float Timer = Time / 35;
	// this will be the var we will use to modify the coords
	float4 distortedCoords;

	// modify the texture coords
	distortedCoords.zw = TexCoords * 0.25; 

	// modify the texture coords ( z and w ) with time
	distortedCoords.xy = TexCoords * float2(1.0, 0.25) * 0.5 + float2(0.0, -Timer);

	// modify the texture coords ( z ) with time
	distortedCoords.w += (sin(Timer) + sin(Timer * 0.5)) * 0.5 + 0.5;

	float4 noise1 = tex2D(WaterNormalSampler, distortedCoords.zw);
	float4 noise2 = tex2D(WaterNormalSampler, distortedCoords.xy);
	float2 waterTexCoords = TexCoords;
	waterTexCoords.y -= Timer * 1.2;
	float4 noise3 = tex2D(WaterDropSampler, waterTexCoords * 2);
	
	float4 noiseF1;
	float4 noiseF2;
	
	if (wetType == 1) {
		noiseF1 = (noise2 + noise3) / 2;
		noiseF2 = (noise1);
	} else {
		noiseF1 = (noise1 + noise2) / 2;
		noiseF2 = (noise3);
	}
	
	float4 noiseVec;
	noiseVec.z = (noiseF1.z * 2.0 - 1.0) * 0.5 + (2.0 * noiseF2.w - 1.0);
	noiseVec.xy = (noiseF1.xy * 2.0 - 1.0);

	// chromatic aberration value. It's a small value, but we can multiply with wetValue
	float3 ca = (0.0001, 0.0001, 0.0001) * wetValue; 

	// get the new refraction vectors 
	float3 refraction0 = normalize(noiseVec.xyz * float3(1.0, 0, 0) + ca); 
	float3 refraction1 = normalize(noiseVec.xyz * float3(1.0, 0, 0) - ca);

	// distort the red channel with refraction0
	float4 waterColor = tex2D(ScreenSourceSampler, TexCoords);
	//distort the red channel with refraction1
	waterColor += tex2D(ScreenSourceSampler, TexCoords - refraction1.xy * 0.025 + refraction0.xy * 0.025).r;
	waterColor -= tex2D(ScreenSourceSampler, TexCoords).r;
	waterColor += tex2D(ScreenSourceSampler, TexCoords - refraction0.xy * 0.025 + refraction1.xy * 0.025).g;
	waterColor -= tex2D(ScreenSourceSampler, TexCoords).g;
	waterColor += tex2D(ScreenSourceSampler, TexCoords - refraction1.xy * 0.025 + refraction0.xy * 0.025).b;
	waterColor -= tex2D(ScreenSourceSampler, TexCoords).b;
	
	float4 mainColor = tex2D(ScreenSourceSampler, TexCoords);
	mainColor += waterColor;
	mainColor /= 2;
	
	// add the highlight to the distorted color
	float4 finalColor;
	
	finalColor = float4(mainColor.rgb, 1);
	
	return finalColor;
}


technique WaterEffects
{
    pass Pass0
    {
        PixelShader = compile ps_2_0 PixelShaderFunction();
    }
}


// Fallback
technique Fallback
{
    pass P0
    {
        // Just draw normally
    }
}