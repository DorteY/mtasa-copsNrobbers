texture Tex;
technique werbung
{
    pass P0
    {
        Texture[0] = Tex;
	AlphaBlendEnable = TRUE;
    }
}