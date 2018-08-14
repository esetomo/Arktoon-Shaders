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
        MaterialProperty Emissionmap;
        MaterialProperty EmissionColor;
        MaterialProperty ShadowBoarderMin;
        MaterialProperty ShadowBoarderMax;
        MaterialProperty ShadowStrength;
        MaterialProperty PointShadowStrength;
        MaterialProperty ShadowStrengthMask;
        MaterialProperty CutoutCutoutAdjust;
        MaterialProperty ShadowPlanBUsePlanB;
        MaterialProperty ShadowPlanBUseShadowMix;
        MaterialProperty ShadowPlanBUseCustomShadowTexture;
        MaterialProperty ShadowPlanBHueShiftFromBase;
        MaterialProperty ShadowPlanBSaturationFromBase;
        MaterialProperty ShadowPlanBValueFromBase;
        MaterialProperty ShadowPlanBCustomShadowTexture;
        MaterialProperty ShadowPlanBCustomShadowTextureRGB;
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
        MaterialProperty ShadowCapBlend;
        MaterialProperty ShadowCapBlendMask;
        MaterialProperty ShadowCapNormalMix;
        MaterialProperty ShadowCapTexture;
        MaterialProperty ShadowCapColor;
        MaterialProperty Cull;
        MaterialProperty ZWrite;
        #endregion

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            Material material = materialEditor.target as Material;
            Shader shader = material.shader;

            // shader.nameによって調整可能なプロパティを制御する。
            bool isOpaque = shader.name.Contains("Opaque");
            bool isFade = shader.name.Contains("Fade");
            bool isCutout = shader.name.Contains("AlphaCutout");

            // FindProperties
            BaseTexture = FindProperty("_MainTex", props);
            BaseColor = FindProperty("_Color", props);
            Normalmap = FindProperty("_Normalmap", props);
            Emissionmap = FindProperty("_Emissionmap", props);
            EmissionColor = FindProperty("_EmissionColor", props);
            if(isCutout) CutoutCutoutAdjust = FindProperty("_CutoutCutoutAdjust", props);
            ShadowBoarderMin = FindProperty("_ShadowBoarderMin", props);
            ShadowBoarderMax = FindProperty("_ShadowBoarderMax", props);
            ShadowStrength = FindProperty("_ShadowStrength", props);
            PointShadowStrength = FindProperty("_PointShadowStrength", props);
            ShadowStrengthMask = FindProperty("_ShadowStrengthMask", props);
            ShadowPlanBUsePlanB = FindProperty("_ShadowPlanBUsePlanB", props);
            ShadowPlanBUseShadowMix = FindProperty("_ShadowPlanBUseShadowMix", props);
            ShadowPlanBUseCustomShadowTexture = FindProperty("_ShadowPlanBUseCustomShadowTexture", props);
            ShadowPlanBHueShiftFromBase = FindProperty("_ShadowPlanBHueShiftFromBase", props);
            ShadowPlanBSaturationFromBase = FindProperty("_ShadowPlanBSaturationFromBase", props);
            ShadowPlanBValueFromBase = FindProperty("_ShadowPlanBValueFromBase", props);
            ShadowPlanBCustomShadowTexture = FindProperty("_ShadowPlanBCustomShadowTexture", props);
            ShadowPlanBCustomShadowTextureRGB = FindProperty("_ShadowPlanBCustomShadowTextureRGB", props);
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
            ShadowCapBlend = FindProperty("_ShadowCapBlend", props);
            ShadowCapBlendMask = FindProperty("_ShadowCapBlendMask", props);
            ShadowCapNormalMix = FindProperty("_ShadowCapNormalMix", props);
            ShadowCapTexture = FindProperty("_ShadowCapTexture", props);
            ShadowCapColor = FindProperty("_ShadowCapColor", props);
            Cull = FindProperty("_Cull", props);
            if(isFade) ZWrite = FindProperty("_ZWrite", props);

            EditorGUIUtility.labelWidth = 0f;

            EditorGUI.BeginChangeCheck();
            {
                EditorGUILayout.LabelField("Common", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Main Texture", "Base Color Texture (RGB)"), BaseTexture, BaseColor);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", "Normal Map (RGB)"), Normalmap);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Emission", "Emission (RGB)"), Emissionmap, EmissionColor);
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
                    materialEditor.ShaderProperty(ShadowBoarderMin, "Shadow Boarder End");
                    materialEditor.ShaderProperty(ShadowBoarderMax, "Shadow Boarder Begin");
                    materialEditor.ShaderProperty(ShadowStrength, "Shadow Strength");
                    materialEditor.ShaderProperty(ShadowStrengthMask, "Shadow Strength Mask");
                    materialEditor.ShaderProperty(ShadowPlanBUsePlanB, "Use Custom Shade");
                    var usePlanB = ShadowPlanBUsePlanB.floatValue;
                    if(usePlanB > 0)
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(ShadowPlanBUseShadowMix, "Mix Default Shadow");
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
                        materialEditor.ShaderProperty(ShadowCapBlend,"Blend");
                        materialEditor.ShaderProperty(ShadowCapBlendMask,"Blend Mask");
                        materialEditor.ShaderProperty(ShadowCapNormalMix,"Normal Map mix");
                        materialEditor.ShaderProperty(ShadowCapTexture,"Texture");
                        materialEditor.ShaderProperty(ShadowCapColor,"Color");
                    }
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.LabelField("", GUI.skin.horizontalSlider);
                EditorGUILayout.LabelField("Advanced", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(PointShadowStrength, "[exp] Point Shadow Str.");
                    materialEditor.ShaderProperty(Cull, "Cull");
                    if(isFade) materialEditor.ShaderProperty(ZWrite, "ZWrite");
                    EditorGUI.indentLevel --;
                }
            }
            EditorGUI.EndChangeCheck();
        }
    }
}