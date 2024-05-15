{{/*
Expand the name of the chart.
*/}}
{{- define "block-buster-helm-app.name" -}}
{{- $name := default .Chart.Name .Values.nameOverride | trunc 60 | trimSuffix "-" }}
{{- printf "a-%s" $name }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "block-buster-helm-app.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- printf "a-%s" (.Release.Name | trunc 60 | trimSuffix "-") }}
{{- else }}
{{- printf "a-%s-%s" (.Release.Name | trunc 30 | trimSuffix "-") ($name | trunc 30 | trimSuffix "-") }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "block-buster-helm-app.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "block-buster-helm-app.labels" -}}
helm.sh/chart: {{ include "block-buster-helm-app.chart" . }}
{{ include "block-buster-helm-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "block-buster-helm-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "block-buster-helm-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "block-buster-helm-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "block-buster-helm-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}