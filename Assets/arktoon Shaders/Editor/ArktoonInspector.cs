using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System;

// Arktoon-Shaders
//
// Copyright (c) 2018 synqark
//
// This code and repos（https://github.com/synqark/Arktoon-Shader) is under MIT licence, see LICENSE
//
// 本コードおよびリポジトリ（https://github.com/synqark/Arktoon-Shader) は MIT License を使用して公開しています。
// 詳細はLICENSEか、https://opensource.org/licenses/mit-license.php を参照してください。
namespace ArktoonShaders
{
    public class ArktoonInspector : ShaderGUI
    {
        #region MaterialProperties
        MaterialProperty BaseTexture;
        MaterialProperty BaseColor;
        MaterialProperty Normalmap;
        MaterialProperty BumpScale;
        MaterialProperty EmissionMap;
        MaterialProperty EmissionColor;
        MaterialProperty Shadowborder;
        MaterialProperty ShadowborderBlur;
        MaterialProperty ShadowStrength;
        MaterialProperty ShadowStrengthMask;
        MaterialProperty ShadowIndirectIntensity;
        MaterialProperty ShadowUseStep;
        MaterialProperty ShadowSteps;
        MaterialProperty PointShadowStrength;
        MaterialProperty PointShadowborder;
        MaterialProperty PointShadowborderBlur;
        MaterialProperty PointShadowUseStep;
        MaterialProperty PointShadowSteps;
        MaterialProperty CutoutCutoutAdjust;
        MaterialProperty ShadowPlanBUsePlanB;
        MaterialProperty ShadowPlanBDefaultShadowMix;
        MaterialProperty ShadowPlanBUseCustomShadowTexture;
        MaterialProperty ShadowPlanBHueShiftFromBase;
        MaterialProperty ShadowPlanBSaturationFromBase;
        MaterialProperty ShadowPlanBValueFromBase;
        MaterialProperty ShadowPlanBCustomShadowTexture;
        MaterialProperty ShadowPlanBCustomShadowTextureRGB;
        MaterialProperty CustomShadow2nd;
        MaterialProperty ShadowPlanB2border;
        MaterialProperty ShadowPlanB2borderBlur;
        MaterialProperty ShadowPlanB2HueShiftFromBase;
        MaterialProperty ShadowPlanB2SaturationFromBase;
        MaterialProperty ShadowPlanB2ValueFromBase;
        MaterialProperty ShadowPlanB2UseCustomShadowTexture;
        MaterialProperty ShadowPlanB2CustomShadowTexture;
        MaterialProperty ShadowPlanB2CustomShadowTextureRGB;
        MaterialProperty UseGloss;
        MaterialProperty GlossBlend;
        MaterialProperty GlossBlendMask;
        MaterialProperty GlossPower;
        MaterialProperty GlossColor;
        MaterialProperty UseOutline;
        MaterialProperty OutlineWidth;
        MaterialProperty OutlineWidthMask;
        MaterialProperty OutlineColor;
        MaterialProperty OutlineTextureColorRate;
        MaterialProperty UseMatcap;
        MaterialProperty MatcapBlendMode;
        MaterialProperty MatcapBlend;
        MaterialProperty MatcapTexture;
        MaterialProperty MatcapColor;
        MaterialProperty MatcapBlendMask;
        MaterialProperty MatcapNormalMix;
        MaterialProperty MatcapShadeMix;
        MaterialProperty UseReflection;
        MaterialProperty ReflectionReflectionPower;
        MaterialProperty ReflectionReflectionMask;
        MaterialProperty ReflectionNormalMix;
        MaterialProperty ReflectionShadeMix;
        MaterialProperty ReflectionCubemap;
        MaterialProperty ReflectionRoughness;
        MaterialProperty UseRim;
        MaterialProperty RimBlend;
        MaterialProperty RimBlendMask;
        MaterialProperty RimShadeMix;
        MaterialProperty RimFresnelPower;
        MaterialProperty RimColor;
        MaterialProperty RimTexture;
        MaterialProperty RimUseBaseTexture;
        MaterialProperty UseShadowCap;
        MaterialProperty ShadowCapBlendMode;
        MaterialProperty ShadowCapBlend;
        MaterialProperty ShadowCapBlendMask;
        MaterialProperty ShadowCapNormalMix;
        MaterialProperty ShadowCapTexture;
        MaterialProperty StencilNumber;
        MaterialProperty StencilCompareAction;
        MaterialProperty Cull;
        MaterialProperty ZWrite;

        MaterialProperty VertexColorBlendDiffuse;
        MaterialProperty VertexColorBlendEmissive;
        MaterialProperty OtherShadowBorderSharpness;
        MaterialProperty OtherShadowAdjust;
        #endregion

        bool _isOpenAdvance;

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            Material material = materialEditor.target as Material;
            Shader shader = material.shader;

            // shader.nameによって調整可能なプロパティを制御する。
            bool isOpaque = shader.name.Contains("Opaque");
            bool isFade = shader.name.Contains("Fade");
            bool isCutout = shader.name.Contains("Cutout");
            bool isStencilWriter = shader.name.Contains("Stencil/Writer");
            bool isStencilReader = shader.name.Contains("Stencil/Reader");

            // FindProperties
            BaseTexture = FindProperty("_MainTex", props);
            BaseColor = FindProperty("_Color", props);
            Normalmap = FindProperty("_BumpMap", props);
            BumpScale = FindProperty("_BumpScale", props);
            EmissionMap = FindProperty("_EmissionMap", props);
            EmissionColor = FindProperty("_EmissionColor", props);
            if(isCutout) CutoutCutoutAdjust = FindProperty("_CutoutCutoutAdjust", props);
            Shadowborder = FindProperty("_Shadowborder", props);
            ShadowborderBlur = FindProperty("_ShadowborderBlur", props);
            ShadowStrength = FindProperty("_ShadowStrength", props);
            ShadowStrengthMask = FindProperty("_ShadowStrengthMask", props);
            ShadowIndirectIntensity = FindProperty("_ShadowIndirectIntensity", props);
            ShadowUseStep = FindProperty("_ShadowUseStep", props);
            ShadowSteps = FindProperty("_ShadowSteps", props);
            PointShadowStrength = FindProperty("_PointShadowStrength", props);
            PointShadowborder = FindProperty("_PointShadowborder", props);
            PointShadowborderBlur= FindProperty("_PointShadowborderBlur", props);
            PointShadowUseStep = FindProperty("_PointShadowUseStep", props);
            PointShadowSteps = FindProperty("_PointShadowSteps", props);
            ShadowPlanBUsePlanB = FindProperty("_ShadowPlanBUsePlanB", props);
            ShadowPlanBDefaultShadowMix = FindProperty("_ShadowPlanBDefaultShadowMix", props);
            ShadowPlanBUseCustomShadowTexture = FindProperty("_ShadowPlanBUseCustomShadowTexture", props);
            ShadowPlanBHueShiftFromBase = FindProperty("_ShadowPlanBHueShiftFromBase", props);
            ShadowPlanBSaturationFromBase = FindProperty("_ShadowPlanBSaturationFromBase", props);
            ShadowPlanBValueFromBase = FindProperty("_ShadowPlanBValueFromBase", props);
            ShadowPlanBCustomShadowTexture = FindProperty("_ShadowPlanBCustomShadowTexture", props);
            ShadowPlanBCustomShadowTextureRGB = FindProperty("_ShadowPlanBCustomShadowTextureRGB", props);

            CustomShadow2nd = FindProperty("_CustomShadow2nd", props);

            ShadowPlanB2border = FindProperty("_ShadowPlanB2border", props);
            ShadowPlanB2borderBlur = FindProperty("_ShadowPlanB2borderBlur", props);
            ShadowPlanB2HueShiftFromBase = FindProperty("_ShadowPlanB2HueShiftFromBase", props);
            ShadowPlanB2SaturationFromBase = FindProperty("_ShadowPlanB2SaturationFromBase", props);
            ShadowPlanB2ValueFromBase = FindProperty("_ShadowPlanB2ValueFromBase", props);
            ShadowPlanB2UseCustomShadowTexture = FindProperty("_ShadowPlanB2UseCustomShadowTexture", props);
            ShadowPlanB2CustomShadowTexture = FindProperty("_ShadowPlanB2CustomShadowTexture", props);
            ShadowPlanB2CustomShadowTextureRGB = FindProperty("_ShadowPlanB2CustomShadowTextureRGB", props);

            UseGloss = FindProperty("_UseGloss", props);
            GlossBlend = FindProperty("_GlossBlend", props);
            GlossBlendMask = FindProperty("_GlossBlendMask", props);
            GlossPower = FindProperty("_GlossPower", props);
            GlossColor = FindProperty("_GlossColor", props);
            if(isOpaque || isCutout) UseOutline = FindProperty("_UseOutline", props);
            if(isOpaque || isCutout) OutlineWidth = FindProperty("_OutlineWidth", props);
            if(isOpaque || isCutout) OutlineWidthMask = FindProperty("_OutlineWidthMask", props);
            if(isOpaque || isCutout) OutlineColor = FindProperty("_OutlineColor", props);
            if(isOpaque || isCutout) OutlineTextureColorRate = FindProperty("_OutlineTextureColorRate", props);
            UseMatcap = FindProperty("_UseMatcap", props);
            MatcapBlendMode = FindProperty("_MatcapBlendMode", props);
            MatcapBlend = FindProperty("_MatcapBlend", props);
            MatcapTexture = FindProperty("_MatcapTexture", props);
            MatcapColor = FindProperty("_MatcapColor", props);
            MatcapBlendMask = FindProperty("_MatcapBlendMask", props);
            MatcapNormalMix = FindProperty("_MatcapNormalMix", props);
            MatcapShadeMix = FindProperty("_MatcapShadeMix", props);
            UseReflection = FindProperty("_UseReflection", props);
            ReflectionReflectionPower = FindProperty("_ReflectionReflectionPower", props);
            ReflectionReflectionMask = FindProperty("_ReflectionReflectionMask", props);
            ReflectionNormalMix = FindProperty("_ReflectionNormalMix", props);
            ReflectionShadeMix = FindProperty("_ReflectionShadeMix", props);
            ReflectionCubemap = FindProperty("_ReflectionCubemap", props);
            ReflectionRoughness = FindProperty("_ReflectionRoughness", props);
            UseRim = FindProperty("_UseRim", props);
            RimBlend = FindProperty("_RimBlend", props);
            RimBlendMask = FindProperty("_RimBlendMask", props);
            RimShadeMix = FindProperty("_RimShadeMix", props);
            RimFresnelPower = FindProperty("_RimFresnelPower", props);
            RimColor = FindProperty("_RimColor", props);
            RimTexture = FindProperty("_RimTexture", props);
            RimUseBaseTexture = FindProperty("_RimUseBaseTexture", props);
            UseShadowCap = FindProperty("_UseShadowCap", props);
            ShadowCapBlendMode = FindProperty("_ShadowCapBlendMode", props);
            ShadowCapBlend = FindProperty("_ShadowCapBlend", props);
            ShadowCapBlendMask = FindProperty("_ShadowCapBlendMask", props);
            ShadowCapNormalMix = FindProperty("_ShadowCapNormalMix", props);
            ShadowCapTexture = FindProperty("_ShadowCapTexture", props);
            if(isStencilWriter || isStencilReader) StencilNumber = FindProperty("_StencilNumber", props);
            if(isStencilReader) StencilCompareAction = FindProperty("_StencilCompareAction", props);
            Cull = FindProperty("_Cull", props);
            VertexColorBlendDiffuse = FindProperty("_VertexColorBlendDiffuse", props);
            VertexColorBlendEmissive = FindProperty("_VertexColorBlendEmissive", props);
            OtherShadowBorderSharpness = FindProperty("_OtherShadowBorderSharpness", props);
            OtherShadowAdjust = FindProperty("_OtherShadowAdjust", props);
            if(isFade) ZWrite = FindProperty("_ZWrite", props);

            EditorGUIUtility.labelWidth = 0f;

            EditorGUI.BeginChangeCheck();
            {
                EditorGUILayout.LabelField("Common", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Main Texture", "Base Color Texture (RGB)"), BaseTexture, BaseColor);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", "Normal Map (RGB)"), Normalmap, BumpScale);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Emission", "Emission (RGB)"), EmissionMap, EmissionColor);
                    materialEditor.ShaderProperty(Cull, "Cull");
                    if(isFade) materialEditor.ShaderProperty(ZWrite, "ZWrite");
                    EditorGUI.indentLevel --;
                }

                if(isCutout){
                    EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                    EditorGUILayout.LabelField("Alpha Cutout", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(CutoutCutoutAdjust, "Cutoff Adjust");
                        EditorGUI.indentLevel --;
                    }
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Shadow", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(Shadowborder, "Border pos");
                    materialEditor.ShaderProperty(ShadowborderBlur, "Border blur");
                    if(ShadowPlanBUsePlanB.floatValue > 0)
                    {
                        EditorGUILayout.LabelField("Strength"," (disabled)", EditorStyles.centeredGreyMiniLabel);
                    } else {
                        materialEditor.ShaderProperty(ShadowStrength, "Strength");
                    }
                    materialEditor.ShaderProperty(ShadowStrengthMask, "Strength Mask");
                    materialEditor.ShaderProperty(ShadowUseStep, "Use Steps");
                    var useStep = ShadowUseStep.floatValue;
                    if(useStep > 0)
                    {
                        materialEditor.ShaderProperty(ShadowSteps, " ");
                    }

                    materialEditor.ShaderProperty(ShadowPlanBUsePlanB, "Use Custom Shade");
                    var usePlanB = ShadowPlanBUsePlanB.floatValue;
                    if(usePlanB > 0)
                    {

                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(ShadowPlanBDefaultShadowMix, "Mix Default Shade");
                        EditorGUILayout.LabelField("1st shade", EditorStyles.boldLabel);
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(ShadowPlanBUseCustomShadowTexture, "Use Shade Texture");
                        var useShadeTexture = ShadowPlanBUseCustomShadowTexture.floatValue;
                        if(useShadeTexture > 0)
                        {
                            materialEditor.ShaderProperty(ShadowPlanBCustomShadowTexture, "Shade Texture");
                            materialEditor.ShaderProperty(ShadowPlanBCustomShadowTextureRGB, "Shade Texture RGB");
                        }
                        else
                        {
                            materialEditor.ShaderProperty(ShadowPlanBHueShiftFromBase, "Hue Shift");
                            materialEditor.ShaderProperty(ShadowPlanBSaturationFromBase, "Saturation");
                            materialEditor.ShaderProperty(ShadowPlanBValueFromBase, "Value");
                        }
                        EditorGUI.indentLevel --;
                        EditorGUILayout.LabelField("2nd shade", EditorStyles.boldLabel);
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(CustomShadow2nd, "Use");
                        var customshadow2nd = CustomShadow2nd.floatValue;
                        if(customshadow2nd > 0)
                        {
                            materialEditor.ShaderProperty(ShadowPlanB2border, "Border pos");
                            materialEditor.ShaderProperty(ShadowPlanB2borderBlur, "Border blur");
                            materialEditor.ShaderProperty(ShadowPlanB2UseCustomShadowTexture, "Use Shade Texture");
                            var useShadeTexture2 = ShadowPlanB2UseCustomShadowTexture.floatValue;
                            if(useShadeTexture2 > 0)
                            {
                                materialEditor.ShaderProperty(ShadowPlanB2CustomShadowTexture,  "Shade Texture");
                                materialEditor.ShaderProperty(ShadowPlanB2CustomShadowTextureRGB,  "Shade Texture RGB");
                            }else{
                                materialEditor.ShaderProperty(ShadowPlanB2HueShiftFromBase, "Hue Shift");
                                materialEditor.ShaderProperty(ShadowPlanB2SaturationFromBase, "Saturation");
                                materialEditor.ShaderProperty(ShadowPlanB2ValueFromBase, "Value");
                            }
                        }

                        EditorGUI.indentLevel --;
                        EditorGUI.indentLevel --;
                    }
                    EditorGUI.indentLevel --;
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Gloss", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(UseGloss, "Use");
                    var useGloss = UseGloss.floatValue;
                    if(useGloss > 0)
                    {
                        materialEditor.ShaderProperty(GlossBlend, "Blend");
                        materialEditor.ShaderProperty(GlossBlendMask, "Blend Mask");
                        materialEditor.ShaderProperty(GlossPower, "Power");
                        materialEditor.ShaderProperty(GlossColor, "Color");
                    }
                    EditorGUI.indentLevel --;
                }

                if(isOpaque || isCutout)  {
                    EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                    EditorGUILayout.LabelField("Outline", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(UseOutline, "Use");
                        var useOutline = UseOutline.floatValue;
                        if(useOutline > 0)
                        {
                            materialEditor.ShaderProperty(OutlineWidth,"Width");
                            materialEditor.ShaderProperty(OutlineWidthMask,"Width Mask");
                            materialEditor.ShaderProperty(OutlineColor,"Color");
                            materialEditor.ShaderProperty(OutlineTextureColorRate,"Base Color Mix");
                        }
                        EditorGUI.indentLevel--;
                    }
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("MatCap", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseMatcap, "Use");
                    var useMatcap = UseMatcap.floatValue;
                    if(useMatcap > 0)
                    {

                        materialEditor.ShaderProperty(MatcapBlendMode,"Blend Mode");
                        materialEditor.ShaderProperty(MatcapBlend,"Blend");
                        materialEditor.ShaderProperty(MatcapBlendMask,"Blend Mask");
                        materialEditor.ShaderProperty(MatcapNormalMix, "Normal Map mix");
                        materialEditor.ShaderProperty(MatcapShadeMix,"Shadow mix");
                        materialEditor.ShaderProperty(MatcapTexture,"Texture");
                        materialEditor.ShaderProperty(MatcapColor,"Color");
                    }
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Reflection", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseReflection, "Use");
                    var useReflection = UseReflection.floatValue;
                    if(useReflection > 0)
                    {
                        materialEditor.ShaderProperty(ReflectionReflectionPower,"Blend");
                        materialEditor.ShaderProperty(ReflectionReflectionMask,"Blend Mask");
                        materialEditor.ShaderProperty(ReflectionNormalMix,"Normal Map mix");
                        materialEditor.ShaderProperty(ReflectionShadeMix, "Shadow mix");
                        materialEditor.ShaderProperty(ReflectionCubemap,"Cubemap");
                        materialEditor.ShaderProperty(ReflectionRoughness,"Roughness");
                    }
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Rim", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseRim, "Use");
                    var useRim = UseRim.floatValue;
                    if(useRim > 0)
                    {
                        materialEditor.ShaderProperty(RimBlend,"Blend");
                        materialEditor.ShaderProperty(RimBlendMask,"Blend Mask");
                        materialEditor.ShaderProperty(RimShadeMix,"Shadow mix");
                        materialEditor.ShaderProperty(RimFresnelPower,"Fresnel Power");
                        materialEditor.ShaderProperty(RimUseBaseTexture,"Use Base Color");
                        materialEditor.ShaderProperty(RimColor,"Color");
                        materialEditor.ShaderProperty(RimTexture,"Texture");
                    }
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Shade Cap", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseShadowCap, "Use");
                    var useShadowCap = UseShadowCap.floatValue;
                    if(useShadowCap > 0)
                    {
                        materialEditor.ShaderProperty(ShadowCapBlendMode,"Blend Mode");
                        materialEditor.ShaderProperty(ShadowCapBlend,"Blend");
                        materialEditor.ShaderProperty(ShadowCapBlendMask,"Blend Mask");
                        materialEditor.ShaderProperty(ShadowCapNormalMix,"Normal Map mix");
                        materialEditor.ShaderProperty(ShadowCapTexture,"Texture");
                    }
                    EditorGUI.indentLevel--;
                }

                if(isStencilWriter)
                {
                    EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                    EditorGUILayout.LabelField("Stencil Writer", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(StencilNumber,"Number");
                        EditorGUI.indentLevel--;
                    }
                }

                if(isStencilReader)
                {
                    EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                    EditorGUILayout.LabelField("Stencil Reader", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(StencilNumber,"Number");
                        materialEditor.ShaderProperty(StencilCompareAction,"Compare Action");
                        EditorGUI.indentLevel--;
                    }
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Advanced", EditorStyles.boldLabel);
                EditorGUILayout.HelpBox("These are some shade tweaking. no need to change usually." + Environment.NewLine + "ほとんどのケースで触る必要のないやつら。",MessageType.Info);
                if (GUILayout.Button("Revert advanced params.")){
                    PointShadowStrength.floatValue = 1f;
                    PointShadowborder.floatValue = 0.25f;
                    PointShadowborderBlur.floatValue = 0.1f;
                    OtherShadowAdjust.floatValue = -0.1f;
                    OtherShadowBorderSharpness.floatValue = 3;
                    PointShadowUseStep.floatValue = 0;
                    material.DisableKeyword("USE_POINT_SHADOW_STEPS");
                    PointShadowSteps.floatValue = 2;
                    ShadowIndirectIntensity.floatValue = 0.25f;
                    VertexColorBlendDiffuse.floatValue = 0f;
                    VertexColorBlendEmissive.floatValue = 0f;
                }
                {
                    EditorGUI.indentLevel ++;
                    EditorGUILayout.LabelField("Directional Shadow", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(ShadowIndirectIntensity, "Indirect face Intensity (0.25)");
                        EditorGUI.indentLevel --;
                    }
                    EditorGUILayout.LabelField("Vertex Colors", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(VertexColorBlendDiffuse, "Color blend to diffuse (def:0) ");
                        materialEditor.ShaderProperty(VertexColorBlendEmissive, "Color blend to emissive (def:0) ");
                        EditorGUI.indentLevel --;
                    }
                    EditorGUILayout.LabelField("PointLight Shadows", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(PointShadowStrength, "Strength (def:1)");
                        materialEditor.ShaderProperty(PointShadowborder, "Border (def:0.25)");
                        materialEditor.ShaderProperty(PointShadowborderBlur, "Border blur (def:0.1)");
                        materialEditor.ShaderProperty(PointShadowUseStep, "Use Steps");
                        var usePointStep = PointShadowUseStep.floatValue;
                        if(usePointStep > 0)
                        {
                            materialEditor.ShaderProperty(PointShadowSteps, " ");
                        }
                        EditorGUI.indentLevel --;
                    }
                    EditorGUILayout.LabelField("Shade from other meshes", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(OtherShadowAdjust, "Adjust (def:-0.1)");
                        materialEditor.ShaderProperty(OtherShadowBorderSharpness, "Sharpness(def:3)");
                        EditorGUI.indentLevel --;
                    }
                    EditorGUI.indentLevel --;
                }
            }
            EditorGUI.EndChangeCheck();
        }
    }
}