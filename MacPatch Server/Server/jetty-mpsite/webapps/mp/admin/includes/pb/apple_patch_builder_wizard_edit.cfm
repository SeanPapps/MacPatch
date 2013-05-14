<cfheader name="expires" value="#now()#">
<cfheader name="pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate">

<cfset isReq="Yes">

<cfquery name="selPatch" datasource="#session.dbsource#">
    select *
    From apple_patches
    Where akey = <cfqueryparam value="#l_akey#">
</cfquery>

<cfquery name="selPatchCri" datasource="#session.dbsource#">
    select *
    From mp_apple_patch_criteria
    Where puuid = <cfqueryparam value="#l_akey#">
    Order By type_action, type_order Asc
</cfquery>


<script type="text/javascript">
    $().ready(function() {
        $('.wiz-container').smartWizard();
    }); 
</script>
<!--- Picker --->
<SCRIPT LANGUAGE="JavaScript">
    function showList(frmEleName) {
      sList = window.open("./includes/pb/patch_picker.cfm?INName="+frmEleName, "list", "width=400,height=500");
    }
    
    function remLink() {
      if (window.sList && window.sList.open && !window.sList.closed)
        window.sList.opener = null;
    }
</SCRIPT>
<!--- Add & Remove Input Form Fields --->
<script type="text/javascript">
    function addFormField(frmFieldName, pid, divid) {
        <cfif selPatchCri.RecordCount EQ 0>
        var id = document.getElementById(pid).value;
        <cfelse>
		var id = <cfoutput>#selPatchCri.RecordCount#</cfoutput>
		</cfif>
        id = (id - 1) + 2;
        document.getElementById(pid).value = id;
        var rmRef = "<img src='./_assets/images/cancel.png' style='vertical-align:middle;' height='14' width='14' onClick='removeFormField(\"#row" + frmFieldName + id +"\")\; return false\;'>";
        $("#"+divid).append("<p id='row" + frmFieldName + id +"' style='margin-top:4px;'>"+rmRef+"&nbsp;<img src='./_assets/images/info.png' style='vertical-align:middle;' height='14' width='14' onClick=\"showList('"+frmFieldName+":"+id+"')\;\">&nbsp;<input type='text' size='50' name='pName" + frmFieldName + ":" + id + "' id='pName" + frmFieldName + ":" + id +"' disabled><input type='hidden' size='20' name='" + frmFieldName + "_" + id + "' id='"+frmFieldName + id +"'>&nbsp;<input type='text' name='"+frmFieldName+"Order_"+id+"' value='"+id+"' size='4'>(Order)&nbsp;<p>");
    }

    function removeFormField(id) {
        $(id).remove();
    }
</script>
<script type="text/javascript">
    function addFormCriteriaField(frmFieldName, pid, divid) {
        <cfif selPatchCri.RecordCount EQ 0>
        var id = document.getElementById(pid).value;
        <cfelse>
		var id = <cfoutput>#selPatchCri.RecordCount#</cfoutput>
		</cfif>
        id = (id - 1) + 2;
        document.getElementById(pid).value = id;
        var rmRef = "<a href='#' onClick='removeFormField(\"#row" + frmFieldName + id +"\"); return false;'><img src='./_assets/images/cancel.png' style='vertical-align:top;margin-top:2px;' height='14' width='14'></a>";
        var sel = "<select name='type_"+ id + "' id='"+frmFieldName + id +"' size='1' style='vertical-align:top\;'><option>Script</option></select><select name='type_action"+ id + "' id='"+frmFieldName + id +"' size='1' style='vertical-align:top\;'><option value='0'>Pre-Install</option><option value='1'>Post-Install</option></select>";
        $("#"+divid).append("<p id='row" + frmFieldName + id +"' style='margin-top:4px;'>&nbsp;"+sel+"&nbsp;<textarea cols=\"90\" rows=\"6\" name='" + frmFieldName + "_" + id + "' id='"+frmFieldName + id +"' cols=\"60\" />&nbsp;<input type='text' name='"+frmFieldName+"Order_"+id+"' value='"+id+"' size='4' style='vertical-align:top\;'><span style='vertical-align:top\;'>(Order)</span>&nbsp;"+rmRef+"</p>");
    }

    function removeFormField(id) {
        $(id).remove();
    }
</script>

<cfif session.IsAdmin EQ true>
	<cfset isReadOnly="false">	
	<cfset action="./includes/pb/apple_update.cfm">
<cfelse>
	<cfset isReadOnly="true">	
	<cfset action="NULL">
</cfif>

<cfform name="UpdateAppleCriteria" method="post" action="#action#">
  <cfinput type="hidden" name="akey" value="#l_akey#">
  <div id="smartwizard" class="wiz-container">
    <ul id="wizard-anchor">
      <li><a href="#wizard-1">
        <h2>Step 1</h2>
        <small>Apple Patch Information</small></a></li>
      <li><a href="#wizard-2">
        <h2>Step 2</h2>
        <small>Patch Criteria</small></a></li>
    </ul>
    <div id="wizard-body" class="wiz-body">
      <div id="wizard-1">
        <div class="wiz-content">
          <h2>Patch Information</h2>
          <p>
          <div id="container">
            <div id="row">
              <div id="left"> Patch Title</div>
              <div id="center" style="color:black;">
                <cfoutput>#selPatch.title#</cfoutput>
              </div>
            </div>
            <div id="row">
              <div id="left"> Patch Version</div>
              <div id="center" style="color:black;">
				<cfoutput>#selPatch.version#</cfoutput>
              </div>
            </div>
			<div id="row">
              <div id="left"> Patch Name</div>
              <div id="center" style="color:black;">
				<cfoutput>#selPatch.supatchname#</cfoutput>
              </div>
            </div>
			<div id="row">
              <div id="left"> Patch Key</div>
              <div id="center" style="color:black;">
				<cfoutput>#selPatch.akey#</cfoutput>
              </div>
            </div>
			<div id="row">
              <div id="left"> Needs Restart</div>
              <div id="center" style="color:black;">
				<cfoutput>#selPatch.restartaction#</cfoutput>
              </div>
            </div>
            <div id="row">
              <div id="left"> Patch Description</div>
              <div id="center" style="color:black;">
				<div style="border: 1px solid black;width:90%;height:230px;overflow-y:scroll;padding:4px;">	
				  <cfoutput>#selPatch.description#</cfoutput>
				</div>  
              </div>
            </div>
            <div id="row">
              <div id="left"> Patch Severity </div>
              <div id="center" style="color:black;">
                <cfselect name="patch_severity" size="1" required="yes">
                <option><cfoutput>#selPatch.severity#</cfoutput></option>
                <option>High</option>
                <option>Medium</option>
                <option>Low</option>
                <option>Unknown</option>
                </cfselect>
              </div>
            </div>
          </div>
        </div>
        </p>
        <div class="wiz-nav">
          <input class="next btn" id="next" type="button" value="Next >" />
        </div>
      </div>
      <div id="wizard-2">
        <div class="wiz-content">
          <h2>Patch Criteria</h2>	
          <p>
          <h3><a href="#" onClick="addFormCriteriaField('reqPatchCriteria','reqid','divTxtReq'); return false;"><img src="./_assets/images/process_add_16.png" />Add Criteria</a></h3>
          <input type="hidden" id="reqid" value="0">
          <div id="divTxtReq">
            <cfoutput query="selPatchCri">
                  <p id="rowreqPatchCriteria#type_order#" style="margin-top:4px;">&nbsp;
                    <select name="type_#type_order#" id="reqPatchCriteria#type_order#" size="1" style="vertical-align:top;">
                      <option #IIf(type is "Script", DE("Selected"), DE(""))#>Script</option>
                    </select>
					<select name="type_action#type_order#" id="reqPatchCriteria#type_action#" size="1" style="vertical-align:top;">
                      <option #IIf(type_action is "0", DE("Selected"), DE(""))# value="0">Pre-Install</option>
					  <option #IIf(type_action is "1", DE("Selected"), DE(""))# value="1">Post-Install</option>
                    </select>
                    &nbsp;
                    <cftextarea name='reqPatchCriteria_#type_order#' id='reqPatchCriteria_#type_order#' cols="90" rows="6" value="#type_data#" />
                    &nbsp;
                    <input type='text' name='reqPatchCriteriaOrder_#type_order#' value='#type_order#' size='3' style='vertical-align:top;'>
                    <span style='vertical-align:top;'>(Order)</span>&nbsp; <a href='##' onClick='removeFormField("##rowreqPatchCriteria#type_order#"); return false;'><img src='./_assets/images/cancel.png' style='vertical-align:top;margin-top:2px;' height='14' width='14'></a> </p>
            </cfoutput>
          </div>
          </p>
        </div>
        <div class="wiz-nav">
          <input class="back btn" id="back" type="button" value="< Back" />
          <cfif isReadOnly EQ "false">
            <input class="btn" id="next" type="submit" value="Save" />
          </cfif>
        </div>
      </div>
    </div>
  </div>
</cfform>
