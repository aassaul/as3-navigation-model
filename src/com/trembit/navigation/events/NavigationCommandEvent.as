/**
 * Created with IntelliJ IDEA.
 * User: Andrey Assaul
 * Date: 15.07.2015
 * Time: 18:08
 */
package com.trembit.navigation.events {
import com.trembit.as3commands.events.CommandEvent;
import com.trembit.as3commands.events.SequenceCommandEvent;
import com.trembit.navigation.commands.NavigationCommand;
import com.trembit.navigation.model.vo.StateVO;

public class NavigationCommandEvent extends SequenceCommandEvent {

	public function NavigationCommandEvent(data:StateVO, prepareDataCommand:Class = null, completeEvent:CommandEvent = null, faultEvent:CommandEvent = null, bubbles:Boolean = false) {
		var commands:Vector.<Class> = prepareDataCommand?new <Class>[prepareDataCommand, NavigationCommand]:new <Class>[NavigationCommand];
		super(commands, data, completeEvent, faultEvent, bubbles);
		data.event = this;
	}
}
}
