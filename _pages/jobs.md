---
layout: page
permalink: /experience/

title: job experience
description: Research, teaching, and professional background
nav: true
nav_order: 2
---

{% assign jobs = site.jobs | sort: "start" | reverse %}

{% for job in jobs %}

## {{ job.title }}

**{{ job.organization }}**  
{{ job.start }} – {{ job.end }}

{% if job.description %}
<ul>
{% for d in job.description %}
<li>{{ d }}</li>
{% endfor %}
</ul>
{% elsif job.content != "" %}
{{ job.content }}

{% endif %}

---

{% endfor %}