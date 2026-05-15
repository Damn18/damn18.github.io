---
layout: page
permalink: /projects/

title: projects
description: Selected coursework and research outputs
nav: true
nav_order: 3
---

{% assign projects = site.projects | sort: "order" %}

{% for project in projects %}

## {{ project.title }}

{% if project.description %}
{{ project.description }}
{% endif %}

{% if project.links %}
<ul>
{% for link in project.links %}
<li><a href="{{ link.url }}" target="_blank">{{ link.name }}</a></li>
{% endfor %}
</ul>
{% endif %}

---

{% endfor %}