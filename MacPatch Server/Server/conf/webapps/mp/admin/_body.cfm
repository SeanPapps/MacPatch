<cfif IsDefined("session.curRef")>
	<cfif #CGI.QUERY_STRING# NEQ session.curRef>
		<cfset session.pasRef = session.curRef>
	</cfif>
</cfif>
<cfset session.curRef = #CGI.QUERY_STRING#>

<!--- Patches --->
	<!--- Apple Patches --->
		<cfif IsDefined("url.patchlist_apple")>
			<cfset ISjqGrid = true>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/available_patches_apple.cfm">
		</cfif>

	<!--- Third Party Patches --->
		<cfif IsDefined("url.mp_patch_list")>
			<cfset ISjqGrid = true>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/available_patches_mp.cfm" />
		</cfif>
		<!--- View the patch --->
		<cfif IsDefined("url.mp_patch_view")>
			<cfset ISPBWizard=true>
			<cfinclude template="./_js.cfm">
			<cfset patchID = #url.mp_patch_view#>
			<cfset isReadOnly = "true">
			<center><cfinclude template="./includes/pb/patch_builder_wizard_edit.cfm"></center>
		</cfif>
		<cfif IsDefined("url.adm_apple_patch_view")>
			<cfset ISPBWizard=true>
			<cfinclude template="./_js.cfm">
			<cfset l_akey = #url.adm_apple_patch_view#>
			<cfset isReadOnly = "true">
			<center><cfinclude template="./includes/pb/apple_patch_builder_wizard_edit.cfm"></center>
		</cfif>

	<!--- Patch Groups --->
		<cfif IsDefined("url.listpatchgroups")>
			<cfinclude template="./_js.cfm">
			<cfinclude template="/admin/includes/list_patch_groups.cfm">
		</cfif>
		<!--- Show the Patch Group --->
		<cfif IsDefined("url.showpatchgroup")>
			<cfset ISjqGrid = true>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/patch_group_show.cfm">
		</cfif>
		<!--- Build the New Patch Group --->
		<cfif IsDefined("url.buildPatchGroup")>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/build_patch_group.cfm">
		</cfif>
		<!--- Create the New Patch Group --->
		<cfif IsDefined("form.CreatePatchGroup")>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/create_patch_group.cfm">
			<cflocation url="#session.cflocFix#/admin/index.cfm?listpatchgroups">
		</cfif>
		<!--- Update/Edit Patch Group --->
			<cfif IsDefined("form.EditPatchGroup") OR IsDefined("URL.EditPatchGroup")>
				<cfinclude template="./_js.cfm">
				<cfinclude template="./includes/edit_patch_groups.cfm">
			</cfif>
			<!--- Update/Edit Patch Group Action --->
			<cfif IsDefined("form.UpdatePatchGroup")>
				<cfinclude template="./includes/update_patch_group.cfm">
				<cflocation url="#session.cflocFix#/admin/index.cfm?listpatchgroups">
			</cfif>
			<!--- Delete Patch Group Action --->
			<cfif IsDefined("form.DeletePatchGroup")>
				<cfquery datasource="#session.dbsource#" name="qGetGroupName">
					Select name From mp_patch_group
					Where id = '#form.name#'
				</cfquery>
				<cfinclude template="./_js.cfm">
				<img src="./_assets/images/caution64.png" /><h3>Warning</h3> Are you sure you want to delete, <cfoutput><b>#qGetGroupName.name#</b></cfoutput>?
				<br>
				This can not be un-done.
				<cfform name="DeletePatchListConfirm" action="/admin/index.cfm">
					<cfinput type="submit" name="DeletePatchListConfirm" value="Delete">
					<cfinput type="submit" name="CancelDeletePatchListConfirm" value="Cancel">
					<cfinput type="hidden" name="group_id" value="#form.name#">
				</cfform>
			</cfif>
			<!--- Cancel Delete Patch Group Action --->
			<cfif IsDefined("form.CancelDeletePatchListConfirm")>
				<cfinclude template="./_js.cfm">
				<cflocation url="#session.cflocFix#/admin/index.cfm?listpatchgroups">
			</cfif>
			<!--- Confirmed Delete Patch Group Action --->
			<cfif IsDefined("form.DeletePatchListConfirm")>
				<cfinclude template="./_js.cfm">
				<cfinclude template="./includes/delete_patch_group.cfm">
				<cflocation url="#session.cflocFix#/admin/index.cfm?listpatchgroups">
			</cfif>

<!--- Installed Patches --->
	<cfif IsDefined("url.installedpatches")>
		<!---
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/installed_patches.cfm">
		--->
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<link rel="stylesheet" type="text/css" media="screen" href="/admin/_assets/js/jquery/jqGrid/src/css/jquery.searchFilter.css" />
		<cfinclude template="./includes/xx_installed_patches.cfm">
	</cfif>

<!--- Client Patch Status --->
	<cfif IsDefined("url.clientstatus")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/client_patch_state.cfm">
	</cfif>

<!--- Client Groups --->
	<cfif IsDefined("url.ClientGroups")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/list_client_groups.cfm">
	</cfif>
	<!---
	<cfif IsDefined("url.ClientGroupsInfo")>
		<cfset ISjqGrid = true>
		<cfset ClientGroupName=#url.ClientGroupName#>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/xx_client_groups.cfm">
	</cfif>
	--->
	<cfif IsDefined("url.ClientGroupsInfo")>
		<cfset ISjqGrid = true>
		<cfif IsDefined("url.ClientGroupName")>
		<cfset ClientGroupName=#url.ClientGroupName#>
		<cfelse>
		<cfset ClientGroupName="x">
		</cfif>
		<cfif isDefined("form.isSearch") AND form.isSearch EQ "1">
			<cfif #Len(Trim(form.data))# GTE 1>
				<cfset fID = #form.field#>
				<cfset fDD = #form.data#>
			</cfif>
		</cfif>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/xx_client_groups.cfm">
	</cfif>
	<cfif IsDefined("url.GridConfig")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/gridSettings.cfm">
	</cfif>
	<cfif IsDefined("url.adm_server_jobs")>
		<cfparam name="url.action" default="-1">
		<cfif IsDefined("url.task")>
			<cfset taskName = #url.task#>
		<cfelse>
			<cfset taskName = "">
		</cfif>
        <!---
        <cfdump>
        <cfif ISDefined("form.fAction")>
        	<cfif form.fAction EQ "AddNewTask">
            	<cfschedule action="update" task="#form.TASKNAME#"
                   url = "#form.url#"
                   startDate = "01/01/2012"
                   enddate="01/01/4000"
                   startTime = "#form.STARTTIME_RECURRING#"
                   interval = "-1"
                   resolveURL = "NO"
                   publish = "NO"
                   requestTimeOut = "600">
            </cfif>
        </cfif>
		--->
		<cfinclude template="./_js.cfm">
		<cfif url.action EQ "1" OR url.action EQ "2">
			<cfinclude template="./includes/admin/jobs/_command.cfm">
		<cfelse>
			<cfinclude template="./includes/admin/jobs/index.cfm">
		</cfif>
	</cfif>
	<cfif IsDefined("url.agent_config")>
		<cfparam name="url.action" default="-1">
		
		<cfif IsDefined("url.agentName")>
			<cfset agentName = #url.agentName#>
		<cfelse>
			<cfset agentName = "">
		</cfif>
		
		<cfinclude template="./_js.cfm">
		<cfif url.action EQ "0" OR url.action EQ "1" OR url.action EQ "2" OR url.action EQ "3">
			<cfinclude template="./includes/admin/_command.cfm">
		<cfelse>
			<cfinclude template="./includes/admin/admin_agent_config.cfm">
		</cfif>
	</cfif>
	
	<!--- SW Dist Groups --->
	<cfif IsDefined("url.adm_sw_group_list")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/sw_group_list.cfm">
    </cfif>
	<cfif IsDefined("url.adm_sw_group_edit")>
		<cfset ISjqGrid = true>
		<cfset l_gid = #url.adm_sw_group_edit#>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/sw_group_tasks.cfm">
    </cfif>
	<cfif IsDefined("url.adm_sw_group_tasks")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
        <cfinclude template="./includes/sw_group_tasks.cfm">
    </cfif>
	
	<!--- Software Tasks --->
    <cfif IsDefined("url.adm_sw_task_list")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
        <cfinclude template="./includes/available_sw_task_mp.cfm">
    </cfif>
    <cfif IsDefined("url.adm_sw_task_new")>
		<cfset ISPBWizard=true>
        <cfinclude template="./_js.cfm">
        <center><cfinclude template="./includes/sw_dist/sw_task_wizard.cfm"></center>
    </cfif>
	<cfif IsDefined("url.adm_sw_task_edit")>
		<cfset ISPBWizard=true>
        <cfinclude template="./_js.cfm">
		<cfset swTaskID = #url.adm_sw_task_edit#>
        <center><cfinclude template="./includes/sw_dist/sw_task_wizard_edit.cfm"></center>
    </cfif>

    <!--- Software Distribution --->
	<cfif IsDefined("url.adm_sw_dist_list")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
        <cfinclude template="./includes/available_sw_dist_mp.cfm">
    </cfif>
	<cfif IsDefined("url.adm_sw_dist_new")>
		<cfset ISPBWizard=true>
        <cfinclude template="./_js.cfm">
        <h2>Build New Content</h2>
        <center><cfinclude template="./includes/sw_dist/sw_dist_wizard.cfm"></center>
    </cfif>
    <cfif IsDefined("url.adm_sw_dist_edit")>
		<cfset ISPBWizard=true>
        <cfinclude template="./_js.cfm">
        <cfset swDistID = #url.adm_sw_dist_edit#>
        <center><cfinclude template="./includes/sw_dist/sw_dist_wizard_edit.cfm"></center>
    </cfif>
	
	
<!--- Admin Menu (non admin) --->
<!--- Baseline --->
	<cfif IsDefined("url.patch_baseline")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/baseline/baseline_patches.cfm" />
	</cfif>
	<cfif isDefined("url.patch_baseline_info")>
		<cfif Len(url.patch_baseline_info) GTE 6>
			<cfset fDD = #url.patch_baseline_info#>
		</cfif>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/baseline/baseline_patches_show.cfm" />
	</cfif>
<!--- Reporting --->
<cfif IsDefined("session.IsAdmin") AND #session.IsAdmin# IS true>
	<cfif IsDefined("url.run_report") OR IsDefined("url.new_report")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/list_reports.cfm" />
		<cfabort>
	</cfif>
</cfif>
<!--- Client Logs --->
<cfif IsDefined("session.IsAdmin") AND #session.IsAdmin# IS true>
	<cfif IsDefined("url.client_logs")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/client_upload_logs.cfm" />
	</cfif>
</cfif>

<!--- Admin --->
<cfif IsDefined("session.IsAdmin") AND #session.IsAdmin# IS true>
	<cfif IsDefined("url.adm_mp_agents")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/admin_client_agent.cfm" />
	</cfif>
	<cfif IsDefined("url.adm_mp_agents_client")>
		<cfset a_type = "client">
		<cfset agentRID = #url.adm_mp_agents_client#>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/admin_agent_upload.cfm" />
	</cfif>
	<cfif IsDefined("url.adm_mp_agents_updater")>
		<cfset a_type = "updater">
		<cfset updaterRID = #url.adm_mp_agents_updater#>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/admin_agent_upload.cfm" />
	</cfif>

	<!--- Proxy Server --->
	<cfif IsDefined("url.adm_mpp_settings")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/admin_proxy.cfm" />
	</cfif>

	<!--- Third Party Patches --->
	<cfif IsDefined("url.adm_mp_patch_list")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/available_patches_mp.cfm" />
	</cfif>
	<cfif IsDefined("url.adm_mp_patch_wizard")>
		<cfset ISPBWizard=true>
		<cfinclude template="./_js.cfm">
		<h2>Build Patch Content</h2>
		<center><cfinclude template="./includes/pb/patch_builder_wizard.cfm" /></center>
	</cfif>
	<cfif IsDefined("url.adm_mp_patch_edit")>
		<cfset ISPBWizard=true>
		<cfinclude template="./_js.cfm">
		<cfset patchID = #url.adm_mp_patch_edit#>
		<center><cfinclude template="./includes/pb/patch_builder_wizard_edit.cfm"></center>
	</cfif>
	<cfif IsDefined("url.adm_apple_patch_edit")>
		<cfset ISPBWizard=true>
		<cfinclude template="./_js.cfm">
		<cfset l_akey = #url.adm_apple_patch_edit#>
		<center><cfinclude template="./includes/pb/apple_patch_builder_wizard_edit.cfm"></center>
	</cfif>
	
	<!--- Baseline --->
	<cfif IsDefined("url.adm_mp_patch_baseline_new")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/baseline/new_baseline.cfm" />
	</cfif>
	<cfif IsDefined("url.adm_mp_patch_baseline_duplicate")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/baseline/create_baseline_copy.cfm" />
	</cfif>
	<cfif IsDefined("url.adm_mp_patch_baseline_create") AND url.adm_mp_patch_baseline_create EQ "True">
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/baseline/create_baseline.cfm" />
	</cfif>
	<!--- Accounts Config --->
	<cfif IsDefined("url.adm_mp_accounts")>
		<cfset ISjqGrid = true>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/admin/admin_accounts.cfm" />
	</cfif>
	<!--- System Config --->
		<cfif IsDefined("url.adm_asus_conf")>
			<cfset ISjqGrid = true>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/admin/admin_asus_servers.cfm">
		</cfif>
		<!--- Logs --->
		<cfif IsDefined("url.adm_mp_logs")>
			<cfset ISjqGrid = true>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/admin/admin_logging_data.cfm">
		</cfif>
		<!--- Database Conf --->
		<cfif IsDefined("url.adm_mp_db_conf")>
			<cfinclude template="./_js.cfm">
			<cfinclude template="./includes/admin/admin_db_config.cfm">
		</cfif>

<cfelseif FindNoCase("adm_mp_",CGI.QUERY_STRING) GTE 1 AND #session.IsAdmin# IS false>
	<cfinclude template="./_js.cfm">
	<h3>Notice:</h3><br>Your account is not a global admin account. You do not have privileges to view this content.
</cfif>
<!--- Dashboard --->
	<cfif IsDefined("url.dashboard")>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/dashboard/index.cfm">
	</cfif>
	
<!--- Default Page (Dashboard) --->
	<cfif StructCount(url) EQ 0 AND StructCount(form) EQ 0>
		<cfinclude template="./_js.cfm">
		<cfinclude template="./includes/dashboard/index.cfm">
	</cfif>
