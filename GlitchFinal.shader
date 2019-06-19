// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Nauman/GlitchFinal"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_CellSize("CellSize", Vector) = (0.05,0.05,0.05,0)
		_CycleTime("CycleTime", Float) = 1
		[NoScaleOffset]_tvbox_AlbedoTransparency1("tv-box_AlbedoTransparency1", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
		};

		uniform float3 _CellSize;
		uniform float _CycleTime;
		uniform sampler2D _tvbox_AlbedoTransparency1;
		uniform float _Cutoff = 0.5;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertexNormal = v.normal.xyz;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 temp_cast_1 = (_Time.y).xx;
			float simplePerlin2D100 = snoise( temp_cast_1 );
			float3 temp_output_110_0 = ceil( ( ( ase_worldPos / _CellSize ) + floor( ( simplePerlin2D100 * 10.0 ) ) ) );
			float dotResult117 = dot( temp_output_110_0 , float3( 39.346,11.135,83.155 ) );
			float dotResult116 = dot( temp_output_110_0 , float3( 12.989,78.233,37.719 ) );
			float dotResult114 = dot( temp_output_110_0 , float3( 73.156,52.235,9.151 ) );
			float4 appendResult118 = (float4(dotResult117 , dotResult116 , dotResult114 , 0.0));
			float4 temp_output_123_0 = frac( sin( appendResult118 ) );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_119_0 = ( ase_vertex3Pos.x - ( 5.0 * sin( ( _Time.y * _CycleTime ) ) ) );
			float smoothstepResult122 = smoothstep( 0.0 , 1.0 , distance( temp_output_119_0 , 0.0 ));
			float4 lerpResult132 = lerp( ( ( float4( ase_vertexNormal , 0.0 ) * temp_output_123_0 ) * 1.5 ) , float4( 0,0,0,0 ) , smoothstepResult122);
			v.vertex.xyz += lerpResult132.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float2 temp_cast_0 = (_Time.y).xx;
			float simplePerlin2D100 = snoise( temp_cast_0 );
			float3 temp_output_110_0 = ceil( ( ( ase_worldPos / _CellSize ) + floor( ( simplePerlin2D100 * 10.0 ) ) ) );
			float dotResult117 = dot( temp_output_110_0 , float3( 39.346,11.135,83.155 ) );
			float dotResult116 = dot( temp_output_110_0 , float3( 12.989,78.233,37.719 ) );
			float dotResult114 = dot( temp_output_110_0 , float3( 73.156,52.235,9.151 ) );
			float4 appendResult118 = (float4(dotResult117 , dotResult116 , dotResult114 , 0.0));
			float4 temp_output_123_0 = frac( sin( appendResult118 ) );
			float2 uv_tvbox_AlbedoTransparency1134 = i.uv_texcoord;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float temp_output_119_0 = ( ase_vertex3Pos.x - ( 5.0 * sin( ( _Time.y * _CycleTime ) ) ) );
			float smoothstepResult122 = smoothstep( 0.0 , 1.0 , distance( temp_output_119_0 , 0.0 ));
			float4 lerpResult135 = lerp( temp_output_123_0 , tex2D( _tvbox_AlbedoTransparency1, uv_tvbox_AlbedoTransparency1134 ) , smoothstepResult122);
			o.Albedo = lerpResult135.rgb;
			o.Alpha = 1;
			float clampResult131 = clamp( ( temp_output_119_0 * 10.0 ) , 0.0 , 1.0 );
			clip( ( clampResult131 + ( (temp_output_123_0).x * ( 1.0 - smoothstepResult122 ) ) ) - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16200
138;304;1398;750;35.44889;-736.4101;1.266538;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;99;-692.8501,470.0926;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;100;-426.7271,462.6473;Float;False;Simplex2D;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;103;-116.8889,479.6083;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;102;-638.2031,52.69354;Float;False;Property;_CellSize;CellSize;1;0;Create;True;0;0;False;0;0.05,0.05,0.05;0.25,0.25,0.25;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;101;-639.342,-190.2396;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;107;-148.3669,-43.11505;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;105;942.288,1278.004;Float;False;Property;_CycleTime;CycleTime;2;0;Create;True;0;0;False;0;1;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;104;962.95,1089.083;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;106;145.4739,469.4247;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;109;1115.289,1234.004;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;108;314.7739,27.29126;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CeilOpNode;110;645.355,32.23105;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;111;1425.462,1046.883;Float;False;Constant;_Float0;Float 0;6;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;112;1323.005,1171.953;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;116;1156.166,179.5298;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;12.989,78.233,37.719;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;115;1207.009,784.4564;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode;117;1179.093,-205.9603;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;39.346,11.135,83.155;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;1616.205,1182.249;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;114;1163.816,518.1393;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;73.156,52.235,9.151;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;118;1640.368,-37.17953;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;119;1701.812,883.5981;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;120;1961.144,95.89056;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DistanceOpNode;121;2316.541,1741.505;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;123;2298.562,181.982;Float;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NormalVertexDataNode;98;2674.384,-878.6351;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;122;2669.662,1627.908;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;124;3021.967,-368.5294;Float;False;Constant;_Float1;Float 1;1;0;Create;True;0;0;False;0;1.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;125;3158.663,1885.198;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;126;2540.74,401.7058;Float;True;True;False;False;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;127;2179.925,1019.843;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;10;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;128;3021.853,-628.9734;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;129;3229.977,-452.2573;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;130;3388.476,1870.085;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;131;3154.814,1473.121;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;134;3809.741,794.1415;Float;True;Property;_tvbox_AlbedoTransparency1;tv-box_AlbedoTransparency1;3;1;[NoScaleOffset];Create;True;0;0;False;0;e83504c35086bb04c9f041635ee97590;fb116b97575df044998b5dd58c7297ee;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;135;4205.524,305.1116;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;132;3352.501,80.85046;Float;True;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;133;3913.065,1588.067;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;7;4624.355,625.0945;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Nauman/GlitchFinal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Transparent;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;100;0;99;0
WireConnection;103;0;100;0
WireConnection;107;0;101;0
WireConnection;107;1;102;0
WireConnection;106;0;103;0
WireConnection;109;0;104;0
WireConnection;109;1;105;0
WireConnection;108;0;107;0
WireConnection;108;1;106;0
WireConnection;110;0;108;0
WireConnection;112;0;109;0
WireConnection;116;0;110;0
WireConnection;117;0;110;0
WireConnection;113;0;111;0
WireConnection;113;1;112;0
WireConnection;114;0;110;0
WireConnection;118;0;117;0
WireConnection;118;1;116;0
WireConnection;118;2;114;0
WireConnection;119;0;115;1
WireConnection;119;1;113;0
WireConnection;120;0;118;0
WireConnection;121;0;119;0
WireConnection;123;0;120;0
WireConnection;122;0;121;0
WireConnection;125;0;122;0
WireConnection;126;0;123;0
WireConnection;127;0;119;0
WireConnection;128;0;98;0
WireConnection;128;1;123;0
WireConnection;129;0;128;0
WireConnection;129;1;124;0
WireConnection;130;0;126;0
WireConnection;130;1;125;0
WireConnection;131;0;127;0
WireConnection;135;0;123;0
WireConnection;135;1;134;0
WireConnection;135;2;122;0
WireConnection;132;0;129;0
WireConnection;132;2;122;0
WireConnection;133;0;131;0
WireConnection;133;1;130;0
WireConnection;7;0;135;0
WireConnection;7;10;133;0
WireConnection;7;11;132;0
ASEEND*/
//CHKSM=E1942FBAAC3B78358DEF4BB14620A2FCD0FA8B92