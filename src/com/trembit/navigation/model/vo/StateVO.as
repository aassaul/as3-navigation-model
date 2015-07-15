/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 17:49
 */
package com.trembit.navigation.model.vo {
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.navigation.events.NavigationCommandEvent;
import com.trembit.navigation.model.NavigationModel;
import com.trembit.reflections.vo.BaseVO;

public class StateVO extends BaseVO {
	[Transient]
	public var stateType:String;
	[Transient]
	public var previousState:StateVO;
	[Ignored]
	public var event:CommandEvent;
	[Ignored]
	public var model:NavigationModel;

	public function StateVO(stateType:String = null, prepareCommand:Class = null, previousState:StateVO = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null) {
		this.stateType = stateType;
		this.previousState = previousState;
		if(stateType){
			event = new NavigationCommandEvent(this, prepareCommand, completeEvent, faultEvent);
		}
	}

	public final function isPreviousForState(state:StateVO):Boolean{
		while(state.previousState){
			if(state.previousState.equals(this)){
				return true;
			}
			state = state.previousState;
		}
		return false;
	}

	override public function equals(value:*):Boolean {
		if(!value){
			return false;
		}
		if(value is String){
			return (stateType == value);
		}
		if(value is StateVO){
			return (stateType == value.stateType);
		}
		return false;
	}
}
}
