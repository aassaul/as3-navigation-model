/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 17:56
 */
package com.trembit.navigation.commands {
import com.trembit.as3commands.commands.Command;
import com.trembit.navigation.model.vo.StateVO;

public class NavigationCommand extends Command {

	override public function get isSingleton():Boolean {
		return false;
	}

	public function get state():StateVO {
		return event.data;
	}

	override protected function execute():void {
		if(state.equals(state.model.currentState) && state != state.model.currentState){
			state.synchronizeWith(state.model.currentState);
			state.model.changeState(state);
		}
		if(state.model.currentState && !state.equals(state.model.currentState) && !state.previousState && !state.isPreviousForState(state.model.currentState)){
			state.previousState = state.model.currentState;
		}
		state.model.currentState = state;
		onComplete(event.data);
	}
}
}
