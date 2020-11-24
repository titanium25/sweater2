<#include "security.ftlh">
<#import "pager.ftlh" as p>

<@p.pager "/mian" page />
<div class="card-columns">
    <#list page.content as message>
        <div class="card my-3">
            <#if message.filename??>
                <img src="${message.filename}" class="card-img-top">
            </#if>
            <div class="m-2">
                <span>${message.text}</span><br>
                <i>#${message.tag}</i>
            </div>
            <div class="card-footer text-muted">
                <a class="btn btn-outline-primary" href="/user-messages/${message.author.id}">
                    ${message.authorName}
                </a>
                <#if message.author.id == currentUserId || isAdmin>
                    <a class="btn btn-outline-primary" href="/user-messages/${message.author.id}?message=${message.id}">
                        Edit
                    </a>
                    <a class="btn btn-outline-primary" href="/deleteMessage/${message.id}">
                        Delete
                    </a>
                </#if>
            </div>
        </div>
    <#else>
        No message
    </#list>
</div>
<@p.pager url page />