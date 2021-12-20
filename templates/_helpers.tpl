{{/*
Produces base name for resources deployed by this chart.
*/}}
{{- define "kafka.baseName" -}}
{{- printf "%s-%s" .Chart.Name .Release.Name | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for all resources deployed by this chart.
*/}}
{{- define "common.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
CMAK selector labels.
*/}}
{{- define "kafka.cmak.selectorLabels" -}}
app.kubernetes.io/component: cmak
{{- end }}
