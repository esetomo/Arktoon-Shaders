using UnityEditor;
using UnityEngine;
using System.Collections.Generic;
using System.Linq;
using System;

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
        MaterialProperty CutoutCutoutAdjust;
        MaterialProperty ShadowPlanBUsePlanB;
        MaterialProperty ShadowPlanBHueShiftFromBase;
        MaterialProperty ShadowPlanBSaturationFromBase;
        MaterialProperty ShadowPlanBValueFromBase;
        MaterialProperty ShadowPlanBUseCustomShadowTexture;
        MaterialProperty ShadowPlanBCustomShadowTexture;
        MaterialProperty UseGloss;
        MaterialProperty GlossBlend;
        MaterialProperty GlossPower;
        MaterialProperty GlossColor;
        MaterialProperty UseOutline;
        MaterialProperty OutlineWidth;
        MaterialProperty OutlineWidthMask;
        MaterialProperty OutlineColor;
        MaterialProperty OutlineTextureColorRate;
        MaterialProperty UseMatcap;
        MaterialProperty MatcapBoost;
        MaterialProperty MatcapTexture;
        MaterialProperty MatcapColor;
        MaterialProperty MatcapMask;
        MaterialProperty UseReflection;
        MaterialProperty ReflectionReflectionPower;
        MaterialProperty ReflectionReflectionMask;
        MaterialProperty ReflectionCubemap;
        MaterialProperty ReflectionCubemapMix;
        MaterialProperty ReflectionRoughness;
        MaterialProperty ReflectionRoughnessmap;
        MaterialProperty UseRim;
        MaterialProperty RimBlend;
        MaterialProperty RimFresnelPower;
        MaterialProperty RimColor;
        MaterialProperty RimTexture;
        MaterialProperty RimUseBaseTexture;
        MaterialProperty UseShadowCap;
        MaterialProperty ShadowCapTexture;
        MaterialProperty ShadowCapMask;
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
            BaseTexture = FindProperty("_BaseTexture", props);
            BaseColor = FindProperty("_BaseColor", props);
            Normalmap = FindProperty("_Normalmap", props);
            Emissionmap = FindProperty("_Emissionmap", props);
            EmissionColor = FindProperty("_EmissionColor", props);
            if(isCutout) CutoutCutoutAdjust = FindProperty("_CutoutCutoutAdjust", props);
            ShadowBoarderMin = FindProperty("_ShadowBoarderMin", props);
            ShadowBoarderMax = FindProperty("_ShadowBoarderMax", props);
            ShadowStrength = FindProperty("_ShadowStrength", props);
            ShadowPlanBUsePlanB = FindProperty("_ShadowPlanBUsePlanB", props);
            ShadowPlanBHueShiftFromBase = FindProperty("_ShadowPlanBHueShiftFromBase", props);
            ShadowPlanBSaturationFromBase = FindProperty("_ShadowPlanBSaturationFromBase", props);
            ShadowPlanBValueFromBase = FindProperty("_ShadowPlanBValueFromBase", props);
            ShadowPlanBUseCustomShadowTexture = FindProperty("_ShadowPlanBUseCustomShadowTexture", props);
            ShadowPlanBCustomShadowTexture = FindProperty("_ShadowPlanBCustomShadowTexture", props);
            UseGloss = FindProperty("_UseGloss", props);
            GlossBlend = FindProperty("_GlossBlend", props);
            GlossPower = FindProperty("_GlossPower", props);
            GlossColor = FindProperty("_GlossColor", props);
            if(isOpaque || isCutout) UseOutline = FindProperty("_UseOutline", props);
            if(isOpaque || isCutout) OutlineWidth = FindProperty("_OutlineWidth", props);
            if(isOpaque || isCutout) OutlineWidthMask = FindProperty("_OutlineWidthMask", props);
            if(isOpaque || isCutout) OutlineColor = FindProperty("_OutlineColor", props);
            if(isOpaque || isCutout) OutlineTextureColorRate = FindProperty("_OutlineTextureColorRate", props);
            UseMatcap = FindProperty("_UseMatcap", props);
            MatcapBoost = FindProperty("_MatcapBoost", props);
            MatcapTexture = FindProperty("_MatcapTexture", props);
            MatcapColor = FindProperty("_MatcapColor", props);
            MatcapMask = FindProperty("_MatcapMask", props);
            UseReflection = FindProperty("_UseReflection", props);
            ReflectionReflectionPower = FindProperty("_ReflectionReflectionPower", props);
            ReflectionReflectionMask = FindProperty("_ReflectionReflectionMask", props);
            ReflectionCubemap = FindProperty("_ReflectionCubemap", props);
            ReflectionCubemapMix = FindProperty("_ReflectionCubemapMix", props);
            ReflectionRoughness = FindProperty("_ReflectionRoughness", props);
            ReflectionRoughnessmap = FindProperty("_ReflectionRoughnessmap", props);
            UseRim = FindProperty("_UseRim", props);
            RimBlend = FindProperty("_RimBlend", props);
            RimFresnelPower = FindProperty("_RimFresnelPower", props);
            RimColor = FindProperty("_RimColor", props);
            RimTexture = FindProperty("_RimTexture", props);
            RimUseBaseTexture = FindProperty("_RimUseBaseTexture", props);
            UseShadowCap = FindProperty("_UseShadowCap", props);
            ShadowCapTexture = FindProperty("_ShadowCapTexture", props);
            ShadowCapMask = FindProperty("_ShadowCapMask", props);
            ShadowCapColor = FindProperty("_ShadowCapColor", props);
            Cull = FindProperty("_Cull", props);
            if(isFade) ZWrite = FindProperty("_ZWrite", props);

            EditorGUIUtility.labelWidth = 0f;

            EditorGUI.BeginChangeCheck();
            {
                EditorGUILayout.LabelField("Common", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.TexturePropertySingleLine(new GUIContent("Base Texture", "Base Color Texture (RGB)"), BaseTexture, BaseColor);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Normal Map", "Normal Map (RGB)"), Normalmap);
                    materialEditor.TexturePropertySingleLine(new GUIContent("Emission", "Emission (RGB)"), Emissionmap, EmissionColor);
                    EditorGUI.indentLevel --;
                }

                if(isCutout){
                    EditorGUILayout.LabelField("Alpha Cutout", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(CutoutCutoutAdjust, "Cutoff Adjust");
                        EditorGUI.indentLevel --;
                    }
                }

                EditorGUILayout.LabelField("Shadow", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(ShadowBoarderMin, "Shadow Boarder End");
                    materialEditor.ShaderProperty(ShadowBoarderMax, "Shadow Boarder Begin");
                    materialEditor.ShaderProperty(ShadowStrength, "Shadow Strength");
                    materialEditor.ShaderProperty(ShadowPlanBUsePlanB, "Use Custom Shade");
                    var usePlanB = ShadowPlanBUsePlanB.floatValue;
                    if(usePlanB > 0)
                    {
                        EditorGUI.indentLevel ++;
                        materialEditor.ShaderProperty(ShadowPlanBHueShiftFromBase, "Hue Shift");
                        materialEditor.ShaderProperty(ShadowPlanBSaturationFromBase, "Saturation");
                        materialEditor.ShaderProperty(ShadowPlanBValueFromBase, "Value");
                        materialEditor.ShaderProperty(ShadowPlanBUseCustomShadowTexture, "Use Shade Texture");
                        materialEditor.ShaderProperty(ShadowPlanBCustomShadowTexture, "Shade Texture");
                        EditorGUI.indentLevel --;
                    }
                    EditorGUI.indentLevel --;
                }

                EditorGUILayout.LabelField("Gloss", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(UseGloss, "Use");
                    var useGloss = UseGloss.floatValue;
                    if(useGloss > 0)
                    {
                        materialEditor.ShaderProperty(GlossBlend, "Blend");
                        materialEditor.ShaderProperty(GlossPower, "Power");
                        materialEditor.ShaderProperty(GlossColor, "Color");
                    }
                    EditorGUI.indentLevel --;
                }

                if(isOpaque || isCutout)  {
                    EditorGUILayout.LabelField("Outline", EditorStyles.boldLabel);
                    {
                        EditorGUI.indentLevel++;
                        materialEditor.ShaderProperty(UseOutline, "Use");
                        var useOutline = UseOutline.floatValue;
                        if(useOutline > 0)
                        {
                            materialEditor.ShaderProperty(OutlineWidth,"Width");
                            materialEditor.ShaderProperty(OutlineWidthMask,"WidthMask");
                            materialEditor.ShaderProperty(OutlineColor,"Color");
                            materialEditor.ShaderProperty(OutlineTextureColorRate,"Base Color Mix");
                        }
                        EditorGUI.indentLevel--;
                    }
                }

                EditorGUILayout.LabelField("MatCap", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseMatcap, "Use");
                    var useMatcap = UseMatcap.floatValue;
                    if(useMatcap > 0)
                    {
                        materialEditor.ShaderProperty(MatcapBoost,"Blend");
                        materialEditor.ShaderProperty(MatcapTexture,"Texture");
                        materialEditor.ShaderProperty(MatcapColor,"Color");
                        materialEditor.ShaderProperty(MatcapMask,"Mask");
                    }
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.LabelField("Reflection", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseReflection, "Use");
                    var useReflection = UseReflection.floatValue;
                    if(useReflection > 0)
                    {
                        materialEditor.ShaderProperty(ReflectionReflectionPower,"Blend");
                        materialEditor.ShaderProperty(ReflectionReflectionMask,"Mask");
                        materialEditor.ShaderProperty(ReflectionCubemap,"Cubemap");
                        materialEditor.ShaderProperty(ReflectionCubemapMix,"Cubemap Mix");
                        materialEditor.ShaderProperty(ReflectionRoughness,"Roughness");
                        materialEditor.ShaderProperty(ReflectionRoughnessmap,"Roughness Map");
                    }
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.LabelField("Rim", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseRim, "Use");
                    var useRim = UseRim.floatValue;
                    if(useRim > 0)
                    {
                        materialEditor.ShaderProperty(RimBlend,"Blend");
                        materialEditor.ShaderProperty(RimFresnelPower,"Fresnel Power");
                        materialEditor.ShaderProperty(RimUseBaseTexture,"Use Base Color");
                        materialEditor.ShaderProperty(RimColor,"Color");
                        materialEditor.ShaderProperty(RimTexture,"Texture");
                    }
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.LabelField("Shade Cap", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel++;
                    materialEditor.ShaderProperty(UseShadowCap, "Use");
                    var useShadowCap = UseShadowCap.floatValue;
                    if(useShadowCap > 0)
                    {
                        materialEditor.ShaderProperty(ShadowCapTexture,"Texture");
                        materialEditor.ShaderProperty(ShadowCapMask,"Mask");
                        materialEditor.ShaderProperty(ShadowCapColor,"Color");
                    }
                    EditorGUI.indentLevel--;
                }

                EditorGUILayout.LabelField("Advanced", EditorStyles.boldLabel);
                {
                    EditorGUI.indentLevel ++;
                    materialEditor.ShaderProperty(Cull, "Cull");
                    if(isFade) materialEditor.ShaderProperty(ZWrite, "ZWrite");
                    EditorGUI.indentLevel --;
                }
            }
            EditorGUI.EndChangeCheck();
        }
    }
}