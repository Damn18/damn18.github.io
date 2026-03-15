---
layout: page
permalink: /honours/
title: honours
description: Honours, Awards and Grants
nav: true
nav_order: 6
---

{% assign honours = site.honours %}
{% if honours %}
{% assign honours = honours | sort: "order"%}

{% for honour in honours %}

## {{ honour.title }}

<strong>{{ honour.organization | markdownify | remove: '<p>' | remove: '</p>' }}</strong><br />
{{ honour.start }}{% if honour.end and honour.end != honour.start %} – {{ honour.end }}{% endif %}

{{ honour.content | markdownify }}

---

{% endfor %}
{% endif %}
